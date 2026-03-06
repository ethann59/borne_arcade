# PianoTile - Documentation

## 1. **Description**

PianoTile est un jeu de type "piano interactive" conçu pour une borne d'arcade. L'objectif du jeu est de permettre aux joueurs de reproduire des mélodies en utilisant les touches du piano virtuel, avec un système de scoring basé sur la précision et la rapidité. Le jeu intègre des modes de jeu variés comme le mode solo, le mode multijoueur, et des fonctionnalités de personnalisation via un profil utilisateur.

Le jeu est optimisé pour une utilisation sur une borne d'arcade, avec un contrôleur composé de joysticks et de boutons physiques, ce qui influence le vocabulaire et les interactions dans l'interface.

## 2. **Stack technique**

- **Langage** : Python
- **Librairie principale** : Pygame
- **Architecture** : Orientée objet, avec une structure modulaire basée sur les fichiers de l'interface et des modules de jeu.

## 3. **Structure principale**

- `main.py` : Point d'entrée du jeu.
- `game.py` : Gestion du cycle de jeu, de l'interface et des événements.
- `ui/` : Dossier contenant les modules d'interface utilisateur.
  - `interface.py` : Gestion de la page courante et des affichages.
  - `layout/` : Gestion des éléments d'affichage.
    - `backgroundView.py` : Affichage des fonds d'écran.
    - `selectionView.py` : Affichage et gestion des sélections.
  - `manager/` : Gestion des éléments de l'interface.
    - `windowManager.py` : Gestion de la fenêtre et des ressources.
  - `utils/` : Outils utilitaires.
    - `image.py` : Gestion des images.
- `core/` : Modules logiques du jeu.
  - `pageState.py` : Énumération des pages de l'interface.
  - `gameData.py` : Gestion des données du jeu.
  - `database.py` : Accès à la base de données.
- `data/` : Fichiers de données.
  - `description.txt` : Description du jeu.
  - `bouton.txt` : Mappage des boutons et contrôles.
- `scripts/` : Scripts d'installation et de lancement.
  - `install.sh` : Script d'installation.
  - `run.sh` : Script de lancement du jeu.

## 4. **Installation / lancement**

Un script d’installation et de lancement est disponible à la racine du projet.

```bash
# Installer les dépendances
./scripts/install.sh

# Lancer le jeu
./scripts/run.sh
```

## 5. **Contrôles borne**

D'après le fichier `bouton.txt` (touches J1 / J2) :

- **Joystick** : Navigation dans les menus.
- **Touche R / A** (X) : Colonne 1.
- **Touche T / Z** (Y) : Colonne 2.
- **Touche Y / E** (Z) : Colonne 3.
- **Touche F / Q** (A) : Colonne 4.
- **Touche G / S** (B) : Non utilisé.
- **Touche H / D** (C) : Valider.
