# Vue d'ensemble - Installation

Cette section décrit comment installer et configurer l'environnement de la borne d'arcade.

## 📦 Prérequis système

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

## 🔧 Configuration de la borne

### 1. Cloner le projet

```bash
git clone <url-du-repo> borne_arcade
cd borne_arcade
```

### 2. Rendre les scripts exécutables

```bash
chmod +x *.sh
chmod +x *.py
chmod +x projet/*/*.sh
```

### 3. Compiler les jeux Java

```bash
./compilation.sh
```

### 4. Tester un jeu

```bash
# Java
./JavaSpace.sh

# Python
./Pong.sh

# Lua
./CursedWare.sh
```

## 🎮 Configuration du clavier

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

## 🚀 Prochaines étapes

- [Installer le générateur de documentation](generator.md)
- [Retour à l'accueil](../index.md)
