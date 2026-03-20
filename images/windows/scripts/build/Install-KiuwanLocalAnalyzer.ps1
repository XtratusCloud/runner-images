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

$archivePath = "$env:IMAGE_FOLDER\libraries\KiuwanLocalAnalyzer.zip"

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

Write-Host "Extracting Kiuwan Local Analyzer to $installDir"
Expand-7ZipArchive -Path $archivePath -DestinationPath $installDir

# Create the .complete marker file
$completeMarker = "$toolsDir\$toolName\$toolVersion\$toolPlatform.complete"
New-Item -Path $completeMarker -ItemType File -Force | Out-Null

Write-Host "Kiuwan Local Analyzer installed successfully at $installDir"

Invoke-PesterTests -TestFile "Tools" -TestName "Kiuwan Local Analyzer"
