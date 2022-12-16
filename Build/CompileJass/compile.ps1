
$JassFolder = "..\..\Trigger"
$CommonJ = ".\JassHelper\common.j"
$BlizzardJ = ".\JassHelper\blizzard.j"
$OutputJ = "war3map.j"
$logs1 = ".\logs\currentmapscript.j"
$logs2 = ".\logs\inputwar3map.j"
$logs3 = ".\logs\outputwar3map.j"
$backups = ".\backups\"
$GeneratedJ = "collection.j"
$Jasshelper = ".\JassHelper\JassHelper\jasshelper.exe"
$MainFunctionFile = ".\Code\main.j"

# Create GeneratedJ file from content of all .j and .zn files
$InputFiles = Get-ChildItem -Path $JassFolder -Include *.j, *.reqj, *.zn -Recurse
New-Item $GeneratedJ -ItemType File -Force

ForEach ($File in $InputFiles) {
        Get-Content -Path $File | Add-Content $GeneratedJ
}

Get-Content -Path $MainFunctionFile | Add-Content $GeneratedJ

$jh = Get-Process jasshelper -ErrorAction SilentlyContinue
if ($jh) {
  # try gracefully first
  $jh.CloseMainWindow()
  # kill after five seconds
  Start-Sleep 1
  if (!$jh.HasExited) {
    $jh | Stop-Process -Force
  }
}
Remove-Variable jh

# Run jasshelper to perform actual compilation of map script
$Params = $args + @('--scriptonly', $CommonJ, $BlizzardJ, $GeneratedJ, $OutputJ)
Start-Process $Jasshelper $Params -NoNewWindow -Wait
if (Test-Path $GeneratedJ) {
    Remove-Item $GeneratedJ
}
if (Test-Path $OutputJ) {
    Remove-Item $OutputJ
}

#Remove logs from previous run
if (Test-Path $logs1) {
    Remove-Item $logs1
}
if (Test-Path $logs2) {
    Remove-Item $logs2
}
if (Test-Path $logs3) {
    Remove-Item $logs3
}

#remove useless backups (dont contain the object data anyway, just the script)
if (Test-Path $backups) {
    Remove-Item $backups -Force -Recurse
}