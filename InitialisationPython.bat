@echo off
cls

echo Des installation sont effectuees dans ce script. Veuillez l'ouvrir en Administrateur.
echo Si vous n'etes pas en Administrateur veuillez fermer cette fenetre et relancer le script en Administrateur.
echo Si non pressez sur Enter pour continuer.

PAUSE

cd C:\

REM Installer Python
echo Installation de python.
echo Cela peux prendre quelques minutes.
C:\PappyJohn\python-3.12.2-amd64.exe /quiet

echo Installation terminee, veuillez presser sur Enter.
PAUSE