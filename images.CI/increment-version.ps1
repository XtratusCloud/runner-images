
# Increments the part of the version string
# Param 1: version itself (e.g. "1.2.3")
# Param 2: number of part: 0 – major, 1 – minor, 2 – patch
param(
    [string]$Version,
    [int]$Part
)

$delimiter = '.'
$array = $Version -split '\.'
$array[$Part] = [int]$array[$Part] + 1
if ($Part -lt 2) { $array[2] = 0 }
if ($Part -lt 1) { $array[1] = 0 }
$newVersion = $array -join $delimiter
Write-Output $newVersion
