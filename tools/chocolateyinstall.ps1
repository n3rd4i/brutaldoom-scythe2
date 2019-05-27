$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. "$toolsDir\commonEnv.ps1"
. "$toolsDir\dependenciesEnv.ps1"

$url = 'ftp://ftp.fu-berlin.de/pc/games/idgames/levels/doom2/Ports/megawads/scythe2.zip'
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $installLocation
  url           = $url
  softwareName  = 'brutaldoom-scythe2*' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique
  checksum      = 'ED108FC02D0615C4CAC9B70BA6D8E205'
  checksumType  = 'md5'
}
Install-ChocolateyZipPackage @packageArgs

$WAD = "`"$installLocation\scythe2.WAD`""

## StartMenu
Install-ChocolateyShortcut -ShortcutFilePath "$startMenuDir\$ModName [BrutalDoom].lnk" `
  -TargetPath "$zandronum" -Arguments "$BDpk3 -file $WAD -iwad $iWAD2" `
  -WorkingDirectory "$installLocation"
Install-ChocolateyShortcut -ShortcutFilePath "$startMenuDir\$ModName [FreeDoom].lnk" `
  -TargetPath "$zandronum" -Arguments "-file $WAD -iwad $iWAD2" `
  -WorkingDirectory "$installLocation" `
  -IconLocation "$FDicon"
Install-ChocolateyShortcut -ShortcutFilePath "$startMenuDir\$ModName Release Notes.lnk" `
  -TargetPath "$installLocation\scythe2.txt"

## StartMenu - Multiplayer
$SMMultiplayerDir = "$startMenuDir\Multiplayer"
Install-ChocolateyShortcut -ShortcutFilePath "$SMMultiplayerDir\$ModName [MP] startServer [LAN].lnk" `
  -TargetPath "$zandronum" -Arguments "$BDpk3 -file $WAD -iwad $iWAD2 -host -port 10666" `
  -WorkingDirectory "$installLocation"
Install-ChocolateyShortcut -ShortcutFilePath "$SMMultiplayerDir\$ModName [MP] joinServer [LAN].lnk" `
  -TargetPath "$zandronum" -Arguments "$BDpk3 -file $WAD -iwad $iWAD2 -connect 127.0.0.1:10666" `
  -WorkingDirectory "$installLocation"

## Desktop
Install-ChocolateyShortcut -ShortcutFilePath "$lnkDesktop" `
  -TargetPath "$zandronum" -Arguments "$BDpk3 -file $WAD -iwad $iWAD2" `
  -WorkingDirectory "$installLocation" `
  -IconLocation "$BDicon"
