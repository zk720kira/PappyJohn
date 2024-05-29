@echo off
cls

cd C:\PappyJohn

REM Installer les dépendances Python
python -m ensurepip
python -m pip install --upgrade pip
echo Installationd es packages requis pour le bon fonctionnement de l'application.
pip install -r requirements.txt

REM Créer la base de données
mysql --user=root --skip-password --execute="CREATE DATABASE IF NOT EXISTS ruegg_thomas_expi1b_pappy_john"

REM Importer le fichier dump SQL
mysql --user=root --skip-password ruegg_thomas_expi1b_pappy_john < database\ruegg_thomas_expi1b_dump.sql

REM exit
exit
