$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. "$toolsDir\commonEnv.ps1"
. "$toolsDir\dependenciesEnv.ps1"

## StartMenu - Multiplayer
$SMMultiplayerDir = "$startMenuDir\Multiplayer"
Install-ChocolateyShortcut "$SMMultiplayerDir\$ModName [MP] startServer [LAN].lnk" `
  -TargetPath "$zandronum" -Arguments "$BDpk3 $WAD -iwad $iWAD2 -host -port 10666" `
  -WorkingDirectory "$installLocation"
Install-ChocolateyShortcut "$SMMultiplayerDir\$ModName [MP] joinServer [LAN].lnk" `
  -TargetPath "$zandronum" -Arguments "$BDpk3 $WAD -iwad $iWAD2 -connect 127.0.0.1:10666" `
  -WorkingDirectory "$installLocation"

Install-ChocolateyShortcut "$startMenuDir\$ModName Release Notes.lnk" `
  -TargetPath "$installLocation\scythe2.txt"

## StartMenu
Install-ChocolateyShortcut "$startMenuDir\$ModName [BrutalDoom].lnk" `
  -TargetPath "$zandronum" -Arguments "$BDpk3 $WAD -iwad $iWAD2" `
  -WorkingDirectory "$installLocation"
