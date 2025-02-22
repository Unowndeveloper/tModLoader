:: After Pulling, Patching, and making sure the version number is changed in src, this bat will compile and create zips for all release.
:: It will also create a zip for ExampleMod

set version=v0.7.1.1
set destinationFolder=.\tModLoader %version% Release

:: Compile/Build exe 
call buildRelease.bat

:: Make up-to-date Installers
cd ..\installer2
call createInstallers.bat
cd ..\solutions

:: Folder for release
mkdir "%destinationFolder%"

:: Temp Folders
mkdir "%destinationFolder%\tModLoader Windows %version%"
mkdir "%destinationFolder%\tModLoader Mac %version%"
mkdir "%destinationFolder%\tModLoader Linux %version%"

:: Windows release
copy ..\src\tModLoader\bin\x86\WindowsRelease\Terraria.exe "%destinationFolder%\tModLoader Windows %version%\Terraria.exe" /y
copy ..\src\tModLoader\bin\x86\MacRelease\Terraria.exe "%destinationFolder%\tModLoader Windows %version%\TerrariaMac.exe" /y
copy ..\src\tModLoader\bin\x86\WindowsServerRelease\Terraria.exe "%destinationFolder%\tModLoader Windows %version%\tModLoaderServer.exe" /y
copy ..\references\FNA.dll "%destinationFolder%\tModLoader Windows %version%\FNA.dll" /y
copy ..\references\MP3Sharp.dll "%destinationFolder%\tModLoader Windows %version%\MP3Sharp.dll" /y
copy ..\installer2\WindowsInstaller.jar "%destinationFolder%\tModLoader Windows %version%\tModLoaderInstaller.jar" /y
copy ReleaseExtras\README_Windows.txt "%destinationFolder%\tModLoader Windows %version%\README.txt" /y

call zipjs.bat zipDirItems -source "%destinationFolder%\tModLoader Windows %version%" -destination "%destinationFolder%\tModLoader Windows %version%.zip" -keep yes -force yes

:: Mac release
copy ..\src\tModLoader\bin\x86\MacRelease\Terraria.exe "%destinationFolder%\tModLoader Mac %version%\Terraria.exe" /y
copy ..\src\tModLoader\bin\x86\WindowsRelease\Terraria.exe "%destinationFolder%\tModLoader Mac %version%\TerrariaWindows.exe" /y
copy ..\src\tModLoader\bin\x86\WindowsServerRelease\Terraria.exe "%destinationFolder%\tModLoader Mac %version%\tModLoaderServer.exe" /y
copy ReleaseExtras\Microsoft.Xna.Framework.dll "%destinationFolder%\tModLoader Mac %version%\Microsoft.Xna.Framework.dll" /y
copy ReleaseExtras\Microsoft.Xna.Framework.Game.dll "%destinationFolder%\tModLoader Mac %version%\Microsoft.Xna.Framework.Game.dll" /y
copy ReleaseExtras\Microsoft.Xna.Framework.Graphics.dll "%destinationFolder%\tModLoader Mac %version%\Microsoft.Xna.Framework.Graphics.dll" /y
copy ReleaseExtras\Microsoft.Xna.Framework.Xact.dll "%destinationFolder%\tModLoader Mac %version%\Microsoft.Xna.Framework.Xact.dll" /y
copy ..\references\MP3Sharp.dll "%destinationFolder%\tModLoader Mac %version%\MP3Sharp.dll" /y
copy ..\installer2\MacInstaller.jar "%destinationFolder%\tModLoader Mac %version%\tModLoaderInstaller.jar" /y
copy ReleaseExtras\README_Mac.txt "%destinationFolder%\tModLoader Mac %version%\README.txt" /y

call zipjs.bat zipDirItems -source "%destinationFolder%\tModLoader Mac %version%" -destination "%destinationFolder%\tModLoader Mac %version%.zip" -keep yes -force yes

:: Linux release
copy ..\src\tModLoader\bin\x86\LinuxRelease\Terraria.exe "%destinationFolder%\tModLoader Linux %version%\Terraria.exe" /y
copy ..\src\tModLoader\bin\x86\WindowsRelease\Terraria.exe "%destinationFolder%\tModLoader Linux %version%\TerrariaWindows.exe" /y
copy ..\src\tModLoader\bin\x86\WindowsServerRelease\Terraria.exe "%destinationFolder%\tModLoader Linux %version%\tModLoaderServer.exe" /y
copy ReleaseExtras\Microsoft.Xna.Framework.dll "%destinationFolder%\tModLoader Linux %version%\Microsoft.Xna.Framework.dll" /y
copy ReleaseExtras\Microsoft.Xna.Framework.Game.dll "%destinationFolder%\tModLoader Linux %version%\Microsoft.Xna.Framework.Game.dll" /y
copy ReleaseExtras\Microsoft.Xna.Framework.Graphics.dll "%destinationFolder%\tModLoader Linux %version%\Microsoft.Xna.Framework.Graphics.dll" /y
copy ReleaseExtras\Microsoft.Xna.Framework.Xact.dll "%destinationFolder%\tModLoader Linux %version%\Microsoft.Xna.Framework.Xact.dll" /y
copy ..\references\MP3Sharp.dll "%destinationFolder%\tModLoader Linux %version%\MP3Sharp.dll" /y
copy ..\installer2\LinuxInstaller.jar "%destinationFolder%\tModLoader Linux %version%\tModLoaderInstaller.jar" /y
copy ReleaseExtras\README_Linux.txt "%destinationFolder%\tModLoader Linux %version%\README.txt" /y

call zipjs.bat zipDirItems -source "%destinationFolder%\tModLoader Linux %version%" -destination "%destinationFolder%\tModLoader Linux %version%.zip" -keep yes -force yes

:: CleanUp, Delete temp Folders
rmdir "%destinationFolder%\tModLoader Windows %version%" /S /Q
rmdir "%destinationFolder%\tModLoader Mac %version%" /S /Q
rmdir "%destinationFolder%\tModLoader Linux %version%" /S /Q

:: Copy to public DropBox Folder
::copy "%destinationFolder%\tModLoader Windows %version%.zip" "C:\Users\Javid\Dropbox\Public\TerrariaModding\tModLoaderReleases\tModLoader Windows %version%.zip"
::copy "%destinationFolder%\tModLoader Mac %version%.zip" "C:\Users\Javid\Dropbox\Public\TerrariaModding\tModLoaderReleases\tModLoader Mac %version%.zip"
::copy "%destinationFolder%\tModLoader Linux %version%.zip" "C:\Users\Javid\Dropbox\Public\TerrariaModding\tModLoaderReleases\tModLoader Linux %version%.zip"

:: ExampleMod.zip (TODO, other parts of ExampleMod release)
rmdir ..\ExampleMod\bin /S /Q
rmdir ..\ExampleMod\obj /S /Q
call zipjs.bat zipItem -source "..\ExampleMod" -destination "%destinationFolder%\ExampleMod %version%.zip" -keep yes -force yes
::copy "%destinationFolder%\ExampleMod %version%.zip" "C:\Users\Javid\Dropbox\Public\TerrariaModding\tModLoaderReleases\"

:: TODO -- tModReader?

echo(
echo(
echo(
echo tModLoader %version% ready to release.
echo(
echo(
pause
