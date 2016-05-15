@echo off

SET version=0.0.1
SET name=jornwarehouse_%version%

rm %name%.zip
mkdir %name%
cp info.json %name%
cp *.lua %name%
cp -r locale/ %name%
"C:\Program Files\7-Zip\7z.exe" a %name%.zip %name%
rm -r %name%/

cp %name%.zip D:\Factorio_0.12.29\mods
echo cp %name%.zip C:\Users\Jorn\AppData\Roaming\Factorio\mods
