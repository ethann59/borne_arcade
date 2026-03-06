# Documentation du Jeu

## 1. Description

Ce jeu est un mini-jeu d'arcade conçu pour une borne d'arcade, utilisant des joysticks et des boutons physiques. L'objectif du joueur est de suivre les instructions données par le jeu, généralement liées à des actions précises sur le clavier ou les manettes, comme se déplacer dans un espace déterminé ou atteindre un objectif spécifique.

Le jeu est intégré dans un système plus vaste nommé **CursedWare**, qui permet de gérer plusieurs mini-jeux avec des mécaniques variées, chacun pouvant être configuré indépendamment.

Contexte : Le jeu est conçu pour une borne d'arcade, donc l'interface et les interactions sont optimisées pour un usage avec des contrôleurs physiques.

## 2. Stack technique

- **Langage** : Lua
- **Moteur de jeu** : LÖVE (version 11.4 ou supérieure)
- **Librairie principale** : LÖVE 2D (pour le rendu graphique et la gestion des événements)
- **Architecture** : Modularité basée sur des modules Lua (fichiers `.lua`)

## 3. Structure principale

- `main.lua` : Point d'entrée du jeu.
- `conf.lua` : Configuration du projet LÖVE.
- `CursedWare/` : Répertoire principal du système de jeux.
  - `src/` : Code source principal.
    - `classes/` : Classes réutilisables (ex. `Color.lua`).
    - `libs/` : Librairies internes (ex. `Instance.lua`, `Classic.lua`).
  - `games/` : Répertoire des mini-jeux.
    - `game1/` : Exemple de mini-jeu (ex. `game1.lua`).
    - `game2/` : Autre mini-jeu (ex. `game2.lua`).
  - `assets/` : Ressources graphiques et sonores partagées.
  - `description.txt` : Fichier de description du jeu.
  - `bouton.txt` : Fichier décrivant les boutons utilisés.
- `run.sh` : Script de lancement du jeu.

## 4. Installation / lancement

Pour lancer le jeu, il faut :

1. Installer LÖVE (version 11.4 ou supérieure).
2. Exécuter le script de lancement :
   ```bash
   ./run.sh
   ```

## 5. Contrôles borne

D'après le fichier `bouton.txt` :

- **Joystick** (flèches) : Déplacement du personnage (haut, bas, gauche, droite).
- **Touche T** (Y) : Interagir.
- **Touche F** (A) : Retour.
- Les autres touches ne sont pas utilisées.
