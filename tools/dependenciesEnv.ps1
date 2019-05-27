$zandronumLocation = "$ENV:LocalAppData\Programs\Zandronum"
# $freedoomLocation = "$ENV:LocalAppData\Programs\FreeDoom"
$brutalDoomLocation = "$ENV:LocalAppData\Programs\BrutalDoom"

$freeDoomTools = "$ENV:ChocolateyInstall\lib\freedoom\tools"
$brutalDoomTools = "$ENV:ChocolateyInstall\lib\brutaldoom\tools"

$zandronum = "$zandronumLocation\zandronum.exe"

# $iWAD1 = "freedoom1.wad"
$iWAD2 = "freedoom2.wad" # located in $ENV:DOOMWADDIR

$BDModName = 'brutalv21'
$BDModPack = "$BDModName.pk3"
$BDpk3 = "$brutalDoomLocation\$BDModPack"

$FDicon = "$freeDoomTools\assets\playa2a8.ico"
$BDicon = "$brutalDoomTools\assets\brutal_doom.ico"
