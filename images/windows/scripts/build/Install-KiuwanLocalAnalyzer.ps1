################################################################################
##  File:  Install-KiuwanLocalAnalyzer.ps1
##  Desc:  Install Kiuwan Local Analyzer
################################################################################

Write-Host "Installing Kiuwan Local Analyzer"

# Following Azure Pipelines Tool Cache structure:
# $AGENT_TOOLSDIRECTORY/KiuwanLocalAnalyzer/1.0.0/x64/

$toolName = "KiuwanLocalAnalyzer"
$toolVersion = "1.0.0"
$toolPlatform = "x64"

# Determine tools directory
$toolsDir = $env:AGENT_TOOLSDIRECTORY
if ([string]::IsNullOrEmpty($toolsDir)) {
    $toolsDir = "C:\hostedtoolcache"
}

Write-Host "IMAGE_FOLDER: $env:IMAGE_FOLDER"
Write-Host "Looking for libraries in: $env:IMAGE_FOLDER\libraries"

$archivePath = Join-Path $env:IMAGE_FOLDER "libraries\KiuwanLocalAnalyzer.zip"

Write-Host "Archive path: $archivePath"

if (-not (Test-Path $archivePath)) {
    Write-Error "File not found: $archivePath"
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
    exit 1
}

$installDir = Join-Path $toolsDir $toolName $toolVersion $toolPlatform

# Remove existing installation and create new directory
if (Test-Path $installDir) {
    Remove-Item -Path $installDir -Recurse -Force
}
New-Item -Path $installDir -ItemType Directory -Force | Out-Null

Write-Host "Extracting Kiuwan Local Analyzer to $installDir"
Expand-7ZipArchive -Path $archivePath -DestinationPath $installDir

# Create the .complete marker file
$completeMarker = Join-Path $toolsDir $toolName $toolVersion "$toolPlatform.complete"
New-Item -Path $completeMarker -ItemType File -Force | Out-Null

Write-Host "Kiuwan Local Analyzer installed successfully at $installDir"

# Run tests
invoke_tests "Tools" "Kiuwan Local Analyzer"
