################################################################################
##  File:  Install-SapJco3.ps1
##  Desc:  Install SAP JCo3
################################################################################

Write-Host "Installing SAP JCo3"

# Following Azure Pipelines Tool Cache structure:
# $AGENT_TOOLSDIRECTORY/sapjco3/3.1.13/x64/sapjco3/

$toolName = "sapjco3"
$toolVersion = "3.1.13"
$toolPlatform = "x64"

$archivePath = "$env:IMAGE_FOLDER\libraries\sapjco3-ntamd64-$toolVersion.zip"

if (-not (Test-Path $archivePath)) {
    Write-Error "File not found: $archivePath"
    exit 1
}

# Determine tools directory
$toolsDir = $env:AGENT_TOOLSDIRECTORY
if ([string]::IsNullOrEmpty($toolsDir)) {
    $toolsDir = "C:\hostedtoolcache"
}

$installDir = "$toolsDir\$toolName\$toolVersion\$toolPlatform"

# Remove existing installation and create new directory
if (Test-Path $installDir) {
    Remove-Item -Path $installDir -Recurse -Force
}
New-Item -Path $installDir -ItemType Directory -Force | Out-Null

Write-Host "Extracting SAP JCo3 to $installDir"
Expand-7ZipArchive -Path $archivePath -DestinationPath $installDir

# Configure environment variables
[Environment]::SetEnvironmentVariable("LD_LIBRARY_PATH", "$installDir;$($env:LD_LIBRARY_PATH)", "Machine")
# Make variable available in the current session
$env:LD_LIBRARY_PATH = "$installDir;$($env:LD_LIBRARY_PATH)"

[Environment]::SetEnvironmentVariable("CLASSPATH", "$installDir;$($env:CLASSPATH)", "Machine")
# Make variable available in the current session
$env:CLASSPATH = "$installDir;$($env:CLASSPATH)"

# Create the .complete marker file
$completeMarker = "$toolsDir\$toolName\$toolVersion\$toolPlatform.complete"
New-Item -Path $completeMarker -ItemType File -Force | Out-Null

Write-Host "SAP JCo3 installed successfully at $installDir"

Invoke-PesterTests -TestFile "Tools" -TestName "SAP JCo3"
