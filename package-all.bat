@echo off
for /d %%d in (factorio-*) do (cd %%d && package.bat && cd ..)
