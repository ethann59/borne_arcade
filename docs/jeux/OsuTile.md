# Documentation du Jeu

## 1. Description

Jeu d'arcade basé sur une mécanique de réaction et de coordination, conçu pour être joué sur une borne d'arcade équipée de joysticks et de boutons. L'objectif est de suivre les séquences d'actions présentées à l'écran, en utilisant les contrôles physiques du jeu pour interagir avec les éléments du niveau.

Le jeu s'inspire des mécaniques de réaction et de timing, avec des niveaux progressifs qui exigent une coordination fine entre les mouvements du joystick et les appuis sur les boutons.

Contexte : Ce jeu est conçu pour fonctionner sur une borne d'arcade, donc il nécessite un environnement contrôlé et des interactions physiques directes avec le joueur.

## 2. Stack technique

- Langage : Python 3.x
- Librairie principale : `pygame` (pour la gestion du rendu graphique et des événements)
- Gestion du son : `pygame.mixer`
- Interface utilisateur : `pygame.display` et `pygame.font`

## 3. Structure principale

- `main.py` : Point d'entrée du jeu, gère le cycle de vie du jeu.
- `game.py` : Contient la logique principale du jeu.
- `levels.py` : Gère les niveaux et les séquences à suivre.
- `input_handler.py` : Gère les entrées des joysticks et boutons.
- `description.txt` : Fichier de description du jeu.
- `bouton.txt` : Fichier décrivant les boutons et leurs rôles.
- `assets/` : Répertoire contenant les ressources graphiques et sonores.
- `config.py` : Fichier de configuration du jeu.
- `install.sh` : Script d'installation (s'il existe).

## 4. Installation / lancement

Pour installer et lancer le jeu :

1. Vérifiez que Python 3.x est installé.
2. Installez les dépendances avec la commande suivante :
   ```bash
   pip install pygame
   ```
3. Exécutez le script d'installation (s'il existe) :
   ```bash
   ./install.sh
   ```
4. Lancez le jeu avec :
   ```bash
   python main.py
   ```

## 5. Contrôles borne

D'après le fichier `bouton.txt` :

- **Joystick** (flèches) : Navigation.
- **Touche R** (X) : Lane 1.
- **Touche T** (Y) : Lane 2.
- **Touche Y** (Z) : Lane 3.
- **Touche F** (A) : Pause.
- **Touche G** (B) : Sélectionner / Reprendre.
- **Touche H** (C) : Quitter.
