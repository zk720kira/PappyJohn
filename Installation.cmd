@echo off
cls

echo Des installation sont effectuees dans ce script. Veuillez l'ouvrir en Administrateur.
echo Si vous n'etes pas en Administrateur veuillez fermer cette fenetre et relancer le script en Administrateur.
echo Si non pressez sur Enter pour demarrer l'installation.

PAUSE

cd C:\

REM Cloner l'application depuis Github
git clone https://github.com/zk720kira/PappyJohn

REM Naviguer vers le répertoire cloné
cd C:\PappyJohn

REM Installer Python
echo Installation de Python.
echo Cela peut prendre quelques minutes.
C:\PappyJohn\python-3.12.2-amd64.exe /quiet PrependPath=1

REM Installer MySQL
echo Installation de MySQL.
echo Cela peut prendre quelques minutes.
winget install Oracle.MySQL

echo Execution du script 'configuration.bat'
C:\PappyJohn\configuration.bat