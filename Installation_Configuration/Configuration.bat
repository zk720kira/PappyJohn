@echo off
cls

echo Les configurations effectuees dans ce script demande des acces Administrateur.
echo Si vous n'etes pas en Administrateur, veuillez fermer cette fenetre et relancer le script en Administrateur.
echo Si non vous pouvez appuyer sur la touche Enter pour commencer la configuration.

PAUSE

cd C:\PappyJohn

REM Installer les dépendances Python
python -m ensurepip
python -m pip install --upgrade pip
echo Installationd es packages requis pour le bon fonctionnement de l'application.
pip install -r requirements.txt

REM Créer la base de données
mysql --user=root --skip-password --execute="CREATE DATABASE IF NOT EXISTS ruegg_thomas_expi1b_pappy_john"

REM Importer le fichier dump SQL
mysql --user=root --skip-password ruegg_thomas_expi1b_pappy_john < C:\PappyJohn\database\ruegg_thomas_expi1b_dump.sql

REM Executer le script python qui permet de créer les utilisateur mysql
python C:\PappyJohn\Create_users.py

REM Ajouter le raccourcis pour l'application Flask (127.0.0.1:8000) sur le bureau
copy "C:\PappyJohn\Pappy John.url" "%userprofile%\Desktop\Pappy John.url"

REM Créer la tâche planifiée
schtasks /create /tn "PappyJohn" /xml "C:\PappyJohn\Pappy John.xml"

echo La configuration est ternimee.
echo Pressez sur la touche Enter pour fermer cette fenetre
PAUSE
