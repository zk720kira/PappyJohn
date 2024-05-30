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

echo L'installation est ternimee. Veuillez executer le script 'Configuration.bat'.
echo Pressez enter pour fermer cette fenetre.
PAUSE
