# Documentation
Cette application WEB permet d'avoir un suivi de ces commandes ainsi que de ces fournisseurs.

# Installation
- Installation de Laragon.
- Configuration de Laragon.
- Installation de Git.
- Installation de l'application.
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
2) Dans l'onglet qui souvre il faut contrôler que toutes les cases soient cochées, si ce n'est pas le cas il faut toutes les cocher.
![](https://onedrive.live.com/embed?resid=E1FF9285CB4A211C%2111294&authkey=%21ADkbHSNsviWsLpw&width=790&height=662)
3) Une fois que c'est fait vous pouvez appuyer sur la croix puis sur "Démarrer".
![](https://onedrive.live.com/embed?resid=E1FF9285CB4A211C%2111295&authkey=%21AGQjqdWb79Ulzus&width=1002&height=669)
**La configuration est ternimée et le serveur MySQL est démarré !**

### Installer Git
Pour pouvoir installer l'application nous devons d'abord installer Git.
Voici le lien pour installer Git : [Git.exe](https://github.com/git-for-windows/git/releases/download/v2.45.1.windows.1/Git-2.45.1-64-bit.exe) \
Une fois installé il faut exécuter l'exécutable.
![]()


### Installer l'application
Pour insteller l'application il faut ouvrir une invite de commande et executé un script.
1) Appuyer sur le boutton Windows.
2) Tapper ***'cmd'*** et appuyer sur la toucher Entrer.
3) Copier ce code : 
```batch=
@echo off
cls
cd C:\
git clone https://github.com/zk720kira/PappyJohn
cd C:\PappyJohn
start explorer C:\PappyJohn
echo Appuyer sur Enter pour fermer la fenentre.
exit
```
4) Coller le dans l'invite de commande et appuyer sur le bouton Enter pour l'exécuter.
5) A la fin de l'installation l'exploreur va s'ouvrir, il faudra exécuter en Administrateur le fichier **'Installation.bat'**.
![]()Pour ce faire il faut faire un clique droite dessus et cliquer sur ***'exécuter en tant qu'administrateur '***.

6) Lorsque vous avez ce message vous pouvez appuyer sur Enter.
7) Une console va denouveau s'ouvrir. Après avoir lu les instructions, appuyer sur Enter pour lancer l'installation.
![]()
8) A la fin de l'installation vous aurez un message qui vous demandera d'exécuter un autre script. Il faut rentourner dans l'explorateur et faire un doubble clique sur ***'Configuration.bat'***.
![]()
9) Cette fois une console va s'ouvrir et se refermer automatiquement après son exécution. Une fois que la fenêtre c'est refermée vous pouvez fermer toutes les invites de commandes soit en cliquant dessus et appuyant sur Enter soit avec la crois en haut à droite de la fenêtre. Vous pouvez aussi fermer l'explorateur de fichier. \
**L'installation est completement terminée.**