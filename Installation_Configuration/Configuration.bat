@echo off
cls

echo Les configurations effectuees dans ce script demande des acces Administrateur.
echo Si vous n'etes pas en Administrateur, veuillez fermer cette fenetre et relancer le script en Administrateur.
echo Si non vous pouvez appuyer sur la touche Enter pour commencer la configuration.

cd C:\PappyJohn

REM Installer les dépendances Python
python -m ensurepip
python -m pip install --upgrade pip
echo Installationd es packages requis pour le bon fonctionnement de l'application.
pip install -r requirements.txt

REM Définir temporairement la variable d'environnment mysql
set PATH=%PATH%;C:\laragon\bin\mysql\mysql-8.8.30-winx64\bin

REM Créer la base de données
mysql --user=root --skip-password --execute="CREATE DATABASE IF NOT EXISTS ruegg_thomas_expi1b_pappy_john"

REM Importer le fichier dump SQL
mysql --user=root --skip-password ruegg_thomas_expi1b_pappy_john < C:\PappyJohn\database\ruegg_thomas_expi1b_dump.sql

REM Executer le script python qui permet de créer les utilisateur mysql
python C:\PappyJohn\Create_users.py

REM Se déplacer dans le System32 pour que la variable d'environnement puisse être ajoutée
cd C:\Windows\System32

REM Ajouter mysql à la variable d'environement PATH du système
setx /M PATH "%PATH%";C:\laragon\bin\mysql\mysql-8.0.30-winx64\bin

echo La configuration est ternimee.
echo Pressez sur la touche Enter pour fermer cette fenetre
PAUSE
