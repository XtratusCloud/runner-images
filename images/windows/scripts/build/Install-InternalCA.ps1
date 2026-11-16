################################################################################
##  File:  Install-InternalCA.ps1
##  Desc:  Install internal CA certificates (root + intermediate) in the machine
##         trust store and in every JDK cacerts truststore
################################################################################

$ErrorActionPreference = "Stop"

$certsFolder = Join-Path $env:IMAGE_FOLDER "certs"
$rootCerts = Get-ChildItem -Path (Join-Path $certsFolder "root") -Include *.pem, *.crt -File -Recurse -ErrorAction SilentlyContinue
$intermediateCerts = Get-ChildItem -Path (Join-Path $certsFolder "intermediate") -Include *.pem, *.crt -File -Recurse -ErrorAction SilentlyContinue

if (-not $rootCerts -and -not $intermediateCerts) {
    Write-Host "No internal CA certificates found in $certsFolder. Skipping."
    exit 0
}

if ($rootCerts) {
    Write-Host "Importing internal root CA certificates into LocalMachine\Root store"
    $rootCerts | ForEach-Object {
        Write-Host "Importing $($_.FullName)"
        Import-Certificate -FilePath $_.FullName -CertStoreLocation Cert:\LocalMachine\Root
    }
}

if ($intermediateCerts) {
    Write-Host "Importing internal intermediate CA certificates into LocalMachine\CA store"
    $intermediateCerts | ForEach-Object {
        Write-Host "Importing $($_.FullName)"
        Import-Certificate -FilePath $_.FullName -CertStoreLocation Cert:\LocalMachine\CA
    }
}

# Import certificates into every JDK cacerts truststore
$jdkRoot = Join-Path $env:AGENT_TOOLSDIRECTORY "Java_Temurin-Hotspot_jdk"
$cacertsFiles = Get-ChildItem -Path $jdkRoot -Filter cacerts -Recurse -ErrorAction SilentlyContinue |
    Where-Object { $_.FullName -match "\\lib\\security\\cacerts$" }

foreach ($cacerts in $cacertsFiles) {
    Write-Host "Importing internal CA certificates into $($cacerts.FullName)"
    $jdkHome = Split-Path (Split-Path (Split-Path $cacerts.FullName))
    $keytool = Join-Path $jdkHome "bin\keytool.exe"

    if (-not (Test-Path $keytool)) {
        Write-Host "keytool not found in $jdkHome, skipping"
        continue
    }

    foreach ($cert in ($rootCerts + $intermediateCerts)) {
        $alias = "xtratus-" + ($cert.BaseName.ToLower() -replace '\s+', '_')
        $exists = & $keytool -list -alias $alias -keystore $cacerts.FullName -storepass changeit 2>$null
        if ($LASTEXITCODE -eq 0) {
            Write-Host "Alias $alias already present in $($cacerts.FullName), skipping"
            continue
        }
        & $keytool -importcert -noprompt -trustcacerts -alias $alias `
            -file $cert.FullName -keystore $cacerts.FullName -storepass changeit
        if ($LASTEXITCODE -ne 0) {
            Write-Host "[Error]: failed to import $alias into $($cacerts.FullName)"
            exit $LASTEXITCODE
        }
    }
}
