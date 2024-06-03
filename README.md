# Documentation
Cette application WEB permet d'avoir un suivi de ces commandes ainsi que de ces fournisseurs.

# Installation
- Installation de Laragon.
- Configuration de Laragon.
- Installation de Git.
- Installation de l'application Flask.
- Démarrer manuellement l'application Flask
### Installer Laragon
Voici le lien pour télécharger Laragon :
[Laragon.exe](https://github.com/leokhoa/laragon/releases/download/6.0.0/laragon-wamp.exe)

Une fois téléchargé, il faut exécuter l'exécutable.
![](https://onedrive.live.com/embed?resid=E1FF9285CB4A211C%2111286&authkey=%21AD9rho5_rleqvb0&width=225&height=40) \
L'exécutable est par défaut dans le dossier ***téléchargement***.

1) Sélectionner la langue d'installation qui vous convient (l'exemple est fait en français).
2) Ensuite appuyer sur "suivant" sans rien changer.
![](https://onedrive.live.com/embed?resid=E1FF9285CB4A211C%2111288&authkey=%21AIAKG8HDBdZ9OcY&width=733&height=559)
3) Par défaut sur la page suivante tous est coché. Si ce n'est pas le cas il faut tous cocher et appuyer sur "Suivant".
![](https://onedrive.live.com/embed?resid=E1FF9285CB4A211C%2111289&authkey=%21AJVZwQUxmAs5Bns&width=734&height=560)
4) Ensuite il faut appuyer sur "Installer".
![](https://onedrive.live.com/embed?resid=E1FF9285CB4A211C%2111290&authkey=%21AGi8z7UFSYff3hY&width=735&height=561)
5) Et pour finir il faut laisser les coches comme elles sont (la 1ère décochée et la 2e cochée) et eppuyer sur "Terminer".
![](https://onedrive.live.com/embed?resid=E1FF9285CB4A211C%2111291&authkey=%21ACVT9rgiwQwedbk&width=730&height=563)
**L'installation est terminée !**

### Configurer Laragon
Ensuite on va de voir effectuer une configuration dans Laragon.
Si vous venez de finir l'installation normalement Laragon c'est ouvert, si ce n'est pas le cas il faut l'ouvrir.
Vous devrez arriver sur cette page :
![](https://onedrive.live.com/embed?resid=E1FF9285CB4A211C%2111292&authkey=%21AAKaa8cdtZQYvBE&width=1006&height=668)
1) Lorsque vous êtes sur cette page il faut appyer sur l'engrenage en haut à droite.
![](https://onedrive.live.com/embed?resid=E1FF9285CB4A211C%2111293&authkey=%21AEh8FZ52GftYb9c&width=1002&height=661)
2) Dans l'onglet qui souvre il faut contrôler que les 2 dernières cases soient cochées, si ce n'est pas le cas il faut les cocher. Il faut aussi décocher la 1ère case si elle est cochée.
![](https://onedrive.live.com/embed?resid=E1FF9285CB4A211C%2111314&authkey=%21APDEF-syo0TucU8&width=793&height=667)
3) Une fois que c'est fait vous pouvez appuyer sur la croix puis sur "Démarrer".
![](https://onedrive.live.com/embed?resid=E1FF9285CB4A211C%2111295&authkey=%21AGQjqdWb79Ulzus&width=1002&height=669)
**La configuration est ternimée et le serveur MySQL est démarré !**

### Installer Git
Pour pouvoir installer l'application nous devons d'abord installer Git.
Voici le lien pour installer Git : [Git.exe](https://github.com/git-for-windows/git/releases/download/v2.45.1.windows.1/Git-2.45.1-64-bit.exe) \
Une fois télécharché il faut exécuter une commande dans une invite de commande en Administrateur.
1) Appuyer sur la touce Windows.
2) Tapper cmd et cliquer sur *'exécuter en tant qu'administrateur'*.
![](https://onedrive.live.com/embed?resid=E1FF9285CB4A211C%2111300&authkey=%21AC6fLN-siTrca_Q&width=782&height=636)
3) Copier la commande ci-dessous et coller la dans l'invite de commande :
```batch=
"%USERPROFILE%\Downloads\Git-2.45.1-64-bit.exe" /silent
```
4) Appuyer sur la touche Enter si la commande ne c'est pas exécutée.
Une fois la command exécutée l'installation de Git commencera. Quand la barre de progression sera pleine la fenêtre se fermera, à ce moment vous pourrez fermer l'invite de commande en cliquant sur la croix en haut à droite. \
**L'instalation de Git est terminée**

### Installer l'application Flask
Pour installer l'application Flask il faut ouvrir une invite de commande et exécuter un script.
1) Appuyer sur le boutton Windows.
2) Tapper ***'cmd'*** et appuyer sur la toucher Enter.
3) Copier ce code : 
```batch=
@echo off
cls
cd C:\
git clone https://github.com/zk720kira/PappyJohn
cd C:\PappyJohn\Installation_Configuration
start explorer C:\PappyJohn\Installation_Configuration
echo Appuyer sur Enter pour fermer la fenentre.
exit
```
4) Coller le dans l'invite de commande et appuyer sur le bouton Enter pour l'exécuter.
5) A la fin de l'installation l'exploreur va s'ouvrir, il faudra exécuter en Administrateur le fichier **'Installation.bat'**.
![](https://onedrive.live.com/embed?resid=E1FF9285CB4A211C%2111301&authkey=%21AICdEjg9O3yG0ng&width=1428&height=348)Pour ce faire il faut faire un clique droite dessus et cliquer sur ***'exécuter en tant qu'administrateur '***.
6) Une console va denouveau s'ouvrir. Après avoir lu les instructions, appuyer sur Enter pour lancer l'installation.
![](https://onedrive.live.com/embed?resid=E1FF9285CB4A211C%2111302&authkey=%21AEe7UoLDfyoHqek&width=1334&height=153)
7) A la fin de l'installation vous aurez un message qui vous demandera d'exécuter un autre script. Il faut rentourner dans l'explorateur et exécuter ***'Configuration.bat'*** en administrateur.
![](https://onedrive.live.com/embed?resid=E1FF9285CB4A211C%2111303&authkey=%21AIzRCIuuf62mPkc&width=1433&height=344)
8) Une fois ce dernier script exécuté vous pouvez fermer toutes les invites de commandes soit en cliquant dessus et appuyant sur Enter soit avec la crois en haut à droite de la fenêtre. Vous pouvez aussi fermer l'explorateur de fichier. \
**L'installation est completement terminée.**

# Utilisation
### Démarrer manuellement l'application Flask
Pour utiliser l'application Flask il faut dabord que Laragon soit démarré ainsi que tous ces services. Une fois Laragon démarré il faut ouvrir un terminal et exécuter cette commande pour démarrer l'application Flask :
```batch=
@echo off
cls
python C:\PappyJohn\app.py
```
Une fois la commande exécutée ceci deverait apparaitre dans l'invite de commande. \
**Il ne faut pas fermer l'invite de commande ni stopper son exécution** si non l'application Flaks ne fonctionnera pas.
![](https://onedrive.live.com/embed?resid=E1FF9285CB4A211C%2111321&authkey=%21ADO3gCvBTu-8seg&width=976&height=513)
Une fois que c'est fait il faut se rendre sur un navigateur et entrer ***'http://127.0.0.1:8000'*** dans la barre URL. \
Normalement vous n'aurez pas besoin de démarrer l'application Flask manuellement car dans le script de configuration (Configuration.bat) tous le lancement de l'application à été automatisé au démarrage de votre ordinateur. \
Et pour faciliter l'accès à l'interface WEB un raccourcis à été ajouté sur votre bureau pour ouvrir automatiquement le navigateur sur ***'http://127.0.0.1:8000'*** \
![](https://onedrive.live.com/embed?resid=E1FF9285CB4A211C%2111315&authkey=%21AKeZIypMT5e2_qU&width=138&height=100) \
**Ce raccourcis ne démarre pas Laragon"** si vous voulez le démarrer manuellement il faut appuyer sur la touche windows, tapper *'Laragon'* et appuyer sur la touche Enter. \
Pour vérifier qu'il soit bien démarrer si vous appuyer sur la flèche en bas à gauche de l'écran (Windows 10) il faut qu'il y ait le même carré que sur l'image ci-dessous. (Windows 11) ce carré doit être à côté de la flèche. \
![](https://onedrive.live.com/embed?resid=E1FF9285CB4A211C%2111316&authkey=%21ANyfYrzfeGOALbU&width=389&height=92)
