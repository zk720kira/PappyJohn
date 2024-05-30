@echo off
cls

echo Demarrage automatique de votre application veuillez patientez.

REM Démarrer Laragon
start C:\laragon\laragon.exe

REM Dormir 2 secondes pour laisser le temp à Laragon de démarrer
timeout /t 2

REM Ouvrir la page web
start http://127.0.0.1:8000

REM Lancer l'application Flask
python C:\PappyJohn\app.py
