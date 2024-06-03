@echo off
cls

echo Des installations sont effectuees dans ce script. Veuillez l'ouvrir en Administrateur.
echo Si vous n'etes pas en Administrateur veuillez fermer cette fenetre et relancer le script en Administrateur.
echo Si non pressez sur Enter pour demarrer l'installation.

PAUSE

REM Naviguer vers le répertoire cloné
cd C:\PappyJohn

REM Installer Python
echo Installation de Python.
echo Cela peut prendre quelques minutes.
C:\PappyJohn\python-3.12.2-amd64.exe /quiet InstallAllUsers=1 CompileAll=1 PrependPath=1

REM Se déplacer dans le System32 pour que la variable d'environnement puisse être ajoutée
cd C:\Windows\System32

REM Ajouter mysql à la variable d'environement PATH du système
REM Les variables d'environnement python doivent être réajoutées
setlocal enabledelayedexpansion

rem Stocker la valeur actuelle de PATH
set "OLD_PATH=%PATH%"

rem Définir la nouvelle valeur de PATH
setx PATH "C:\Program Files\Python312\Scripts\;C:\Program Files\Python312\;%OLD_PATH%;C:\laragon\bin\mysql\mysql-8.0.30-winx64\bin" /M

echo La configuration est ternimee. Veuillez executer le script 'Configuration.bat'.
echo Pressez sur la touche Enter pour fermer cette fenetre.
PAUSE
