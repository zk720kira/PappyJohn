@echo off
cls

REM Se déplacer dans le System32 pour que la variable d'environnement puisse être ajoutée
cd C:\Windows\System32

REM Ajouter mysql à la variable d'environement PATH du système
setx /M PATH "%PATH%";C:\laragon\bin\mysql\mysql-8.0.30-winx64\bin

exit