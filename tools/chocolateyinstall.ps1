$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$zandronumLocation = "$ENV:LocalAppData\Programs\Zandronum"
$freedoomLocation = "$ENV:LocalAppData\Programs\FreeDoom"
$brutalDoomLocation = "$ENV:LocalAppData\Programs\BrutalDoom"
$installLocation = "$ENV:LocalAppData\Programs\BrutalDoom Scythe2"
$startMenuLocation = "$ENV:AppData\Microsoft\Windows\Start Menu\Programs\BrutalDoom Scythe2"
$startMenuMultiplayerLocation = "$ENV:AppData\Microsoft\Windows\Start Menu\Programs\BrutalDoom Scythe2\Multiplayer"

## Icons
$lnkDesktop = "$ENV:UserProfile\Desktop\Scythe2.lnk"
$lnkStartMenu = "$startMenuLocation\Scythe2 [BD].lnk"
$lnkReleaseNote = "$startMenuLocation\Scythe2 Release Notes.lnk"
$lnkStartServer = "$startMenuMultiplayerLocation\Scythe2 BD startServer [LAN].lnk"
$lnkJoinServer = "$startMenuMultiplayerLocation\Scythe2 BD joinServer [LAN].lnk"

$BDModName = 'brutalv21'
$BDModPack = "$BDModName.pk3"
$WAD = "scythe2.wad"

New-Item -ItemType Directory -Force -Path "$installLocation"
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $installLocation
  url           = 'ftp://ftp.fu-berlin.de/pc/games/idgames/levels/doom2/Ports/megawads/scythe2.zip' # download url, HTTPS preferred
  softwareName  = 'brutaldoom.scythe2*' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique
  checksum      = 'ED108FC02D0615C4CAC9B70BA6D8E205'
  checksumType  = 'md5'
}
Install-ChocolateyZipPackage @packageArgs

## Desktop
Install-ChocolateyShortcut -ShortcutFilePath "$lnkDesktop" `
  -TargetPath "$zandronumLocation\zandronum.exe" `
  -Arguments "-file `"$installLocation\$WAD`" `"$brutalDoomLocation\$BDModPack`" -iwad freedoom2.wad" `
  -IconLocation "$ENV:ChocolateyInstall\lib\brutaldoom\tools\assets\brutal_doom.ico" `
  -WorkingDirectory "$installLocation"

## Start Menu
Install-ChocolateyShortcut -ShortcutFilePath "$lnkStartMenu" `
  -TargetPath "$zandronumLocation\zandronum.exe" `
  -Arguments "-file `"$installLocation\$WAD`" `"$brutalDoomLocation\$BDModPack`" -iwad freedoom2.wad" `
  -IconLocation "$ENV:ChocolateyInstall\lib\brutaldoom\tools\assets\brutal_doom.ico" `
  -WorkingDirectory "$installLocation"
Install-ChocolateyShortcut -ShortcutFilePath "$startMenuLocation\Scythe2 [FD].lnk" `
  -TargetPath "$zandronumLocation\zandronum.exe" `
  -IconLocation "$ENV:ChocolateyInstall\lib\freedoom\tools\assets\playa2a8.ico" `
  -Arguments "-file `"$installLocation\$WAD`" -iwad freedoom2.wad" `
  -WorkingDirectory "$installLocation"

Install-ChocolateyShortcut -ShortcutFilePath "$lnkReleaseNote" `
  -TargetPath "$installLocation\scythe2.txt" `
  -Description "Brutal Doom - Scythe2 Release Notes"

## Multiplayer [Start Menu] ##
Install-ChocolateyShortcut -ShortcutFilePath "$lnkStartServer" `
  -TargetPath "$zandronumLocation\zandronum.exe" `
  -IconLocation "$zandronumLocation\zandronum.exe" `
  -Arguments "-file `"$installLocation\$WAD`" `"$brutalDoomLocation\$BDModPack`" -iwad freedoom2.wad -port 10666 +sv_maxlives 0 -host +alwaysapplydmflags 1" `
  -Description "Start LAN server [BrutalDoom]" `
  -WorkingDirectory "$installLocation"

Install-ChocolateyShortcut -ShortcutFilePath "$lnkJoinServer" `
  -TargetPath "$zandronumLocation\zandronum.exe" `
  -IconLocation "$zandronumLocation\zandronum.exe" `
  -Arguments "-file `"$installLocation\$WAD`" `"$brutalDoomLocation\$BDModPack`" -iwad freedoom2.wad -connect 127.0.0.1:10666" `
  -Description "Join Local LAN server [BrutalDoom]" `
  -WorkingDirectory "$installLocation"

