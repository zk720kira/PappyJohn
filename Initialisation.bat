@echo off
cls

cd C:\

REM Cloner le dépôt GitHub
git clone https://github.com/zk720kira/PappyJohn

REM Naviguer vers le répertoire cloné
cd C:\PappyJohn

REM Installer Python
C:\PappyJohn\python-3.12.2-amd64.exe /quiet

REM Installer les dépendances Python
python -m ensurepip
python -m pip install --upgrade pip
pip install -r requirements.txt

REM Installer MySQL
winget install Oracle.MySQL

REM Créer la base de données
mysql --user=root --skip-password --execute="CREATE DATABASE IF NOT EXISTS ruegg_thomas_expi1b_pappy_john"

REM Importer le fichier dump SQL
mysql --user=root --skip-password ruegg_thomas_expi1b_pappy_john < database\ruegg_thomas_epxi1b_dump.sql