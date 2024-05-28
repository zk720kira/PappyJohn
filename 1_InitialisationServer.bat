@echo off
cls

echo Des installation sont effectuees dans ce script. Veuillez l'ouvrir en Administrateur.
echo Si vous n'etes pas en Administrateur veuillez fermer cette fenetre et relancer le script en Administrateur.
echo Si non pressez sur Enter pour continuer.

PAUSE

REM Naviguer vers le répertoire cloné
cd C:\PappyJohn

REM Installer Python
echo Installation de python.
echo Cela peux prendre quelques minutes.
C:\PappyJohn\python-3.12.2-amd64.exe PrependPath=1 /quiet

REM Installer les dépendances Python
python -m ensurepip
python -m pip install --upgrade pip
echo Installation des packages requis pour le fonctionnement de l'application.
pip install -r requirements.txt

REM Installer MySQL
echo Installation de MySQL.
echo Cela peux prendre quelques minutes.
winget install Oracle.MySQL

REM Créer la base de données
mysql --user=root --skip-password --execute="CREATE DATABASE IF NOT EXISTS ruegg_thomas_expi1b_pappy_john"

REM Importer le fichier dump SQL
mysql --user=root --skip-password ruegg_thomas_expi1b_pappy_john < database\ruegg_thomas_epxi1b_dump.sql

echo Installation terminee, veuillez presser sur Enter.
PAUSE