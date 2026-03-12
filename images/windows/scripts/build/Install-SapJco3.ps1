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

$archivePath = Join-Path $env:IMAGE_FOLDER "libraries\sapjco3-ntamd64-$toolVersion.zip"

Write-Host "IMAGE_FOLDER: $env:IMAGE_FOLDER"
Write-Host "Looking for libraries in: $env:IMAGE_FOLDER\libraries"
Write-Host "Archive path: $archivePath"

if (-not (Test-Path $archivePath)) {
    Write-Host "ERROR: File not found: $archivePath"
    Write-Host "Checking if libraries directory exists:"
    $librariesPath = Join-Path $env:IMAGE_FOLDER "libraries"
    if (Test-Path $librariesPath) {
        Write-Host "Libraries directory exists. Contents:"
        Get-ChildItem -Path $librariesPath -ErrorAction SilentlyContinue | ForEach-Object { Write-Host "  $_" }
    } else {
        Write-Host "Libraries directory does not exist at: $librariesPath"
    }
    Write-Host "Contents of IMAGE_FOLDER:"
    Get-ChildItem -Path $env:IMAGE_FOLDER -ErrorAction SilentlyContinue | ForEach-Object { Write-Host "  $_" }
    Write-Error "File not found: $archivePath"
    exit 1
}

# Determine tools directory
$toolsDir = $env:AGENT_TOOLSDIRECTORY
if ([string]::IsNullOrEmpty($toolsDir)) {
    $toolsDir = "C:\hostedtoolcache"
}
$installDir = Join-Path $toolsDir $toolName | Join-Path -ChildPath $toolVersion | Join-Path -ChildPath $toolPlatform

# Remove existing installation and create new directory
if (Test-Path $installDir) {
    Remove-Item -Path $installDir -Recurse -Force
}
New-Item -Path $installDir -ItemType Directory -Force | Out-Null

Write-Host "Extracting SAP JCo3 to $installDir"
Expand-7ZipArchive -Path $archivePath -DestinationPath $installDir

# Configure environment variables
$env:LD_LIBRARY_PATH = "$installDir;$($env:LD_LIBRARY_PATH)"
$env:CLASSPATH = "$installDir;$($env:CLASSPATH)"

# Create the .complete marker file
$completeMarker = Join-Path $toolsDir $toolName $toolVersion "$toolPlatform.complete"
New-Item -Path $completeMarker -ItemType File -Force | Out-Null

Write-Host "SAP JCo3 installed successfully at $installDir"

# Run tests
invoke_tests "Tools" "SAP JCo3"
