# Documentation d'Installation de la Borne d'Arcade

## Prérequis système

### Système d'exploitation

- Raspberry Pi OS (64-bit) recommandé pour la compatibilité avec les jeux et les dépendances.
- Accès root ou sudo pour certaines installations

### Logiciels requis

#### Pour tous les jeux

```bash
sudo apt update
sudo apt install -y git build-essential
```

#### Pour les jeux Java

```bash
sudo apt install -y openjdk-25-jdk
java -version  # Vérifier : Java 25+
```

#### Pour les jeux Python

```bash
sudo apt install -y python3 python3-pip
python3 --version  # Vérifier : Python 3.8+
```

Installer les dépendances Python :

```bash
pip3 install pygame
```

#### Pour les jeux Lua

```bash
sudo apt install -y love
love --version  # Vérifier : Love2D 11.x
```

## Installation du système d'exploitation

1. Installez Raspberry Pi OS (64-bit) sur votre Raspberry Pi.
2. Assurez-vous que votre Raspberry Pi est connecté à Internet.

## Clonage du projet

1. Créez un répertoire git :

```bash
cd ~
mkdir git
cd git
```

2. Clonez les dépôts nécessaires :

```bash
git clone https://github.com/ethann59/borne_arcade.git
```

À la fin de cette étape, vous devez avoir l'arborescence suivante :
- répertoire personnel
  - |
  - |-> git
    - |
    - |-> borne_arcade

> **Note** : MG2D est inclus dans le dépôt (`MG2D/mg2d.jar`), il n'est plus nécessaire de le cloner séparément.

## Configuration des scripts

1. Rendez les scripts exécutables :

```bash
chmod +x *.sh
chmod +x *.py
chmod +x projet/*/*.sh
```

2. Compilez les jeux Java :

```bash
./compilation.sh
```

## Configuration du clavier

La borne utilise un clavier arcade avec configuration spéciale. Voir [ClavierBorneArcade.java](../../ClavierBorneArcade.java) pour les mappings.

### Mapping par défaut

**Joystick J1** :
- Haut/Bas/Gauche/Droite : Flèches directionnelles

**Joystick J2** :
- Haut : O
- Bas : L  
- Gauche : K
- Droite : M

**6 touches J1** :
- Ligne haute : R, T, Y
- Ligne basse : F, G, H

**6 touches J2** :
- Ligne haute : A, Z, E
- Ligne basse : Q, S, D

## Lancement du logiciel au démarrage

1. Déplacez le fichier de démarrage dans le bon répertoire :

```bash
mkdir -p ~/.config/autostart/
cp ./borne.desktop ~/.config/autostart/
```

2. Redémarrez le système pour tester le lancement automatique.

## Validation post-installation

1. Vérifiez que tous les jeux sont fonctionnels en lançant un jeu individuel :

```bash
./JavaSpace.sh
```

2. Testez le générateur de documentation si disponible :

```bash
python3 test_ollama.py
```

3. Vérifiez que les fichiers de documentation sont générés correctement :

```bash
ls -la projet/JavaSpace/DOCUMENTATION.md
ls -la projet/JavaSpace/tests/Tests.java
```

## Dépannage de base

### Problème : Accès au serveur Ollama

1. Vérifiez que le serveur est démarré :

```bash
curl http://10.22.28.190:11434/api/version
```

2. Testez la connexion réseau :

```bash
ping 10.22.28.190
```

### Problème : Modèle non trouvé

Téléchargez le modèle :

```bash
ollama pull qwen3
```

Ou utilisez un modèle plus léger :

```bash
ollama pull qwen2.5:7b
```

### Problème : Permissions

Assurez-vous que tous les scripts sont exécutables :

```bash
chmod +x *.sh *.py
```
