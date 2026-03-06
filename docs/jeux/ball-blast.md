# Mini Documentation - Ball Blast

## 1. **Description**

**Objectif** : Détruire des balles de différentes tailles en les faisant exploser avec un canon contrôlé par le joueur. Le jeu se déroule en plusieurs niveaux avec une progression de difficulté.

**Contexte borne** : Ce jeu est conçu pour une borne d'arcade équipée de joysticks et de boutons. Il est optimisé pour un gameplay rapide et intuitif, adapté à un usage en environnement public.

## 2. **Stack technique**

- **Langage** : Python
- **Lib principale** : Pygame

## 3. **Structure principale**

- `src/menu.py` : Gestion du menu principal et des options (pause, crédits, quitter).
- `src/game.py` : Boucle principale du jeu, gestion des états (menu, jeu, pause, crédits).
- `src/player.py` : Classe du joueur (canon et roues).
- `src/ball.py` : Classe des balles (génération, destruction, explosion).
- `src/constantes.py` : Définition des constantes (taille écran, vitesses, couleurs).
- `src/bullet.py` : Gestion des balles de canon (tir, déplacement).
- `src/score.py` : Gestion du score et enregistrement des meilleurs scores.

## 4. **Installation / lancement**

Aucun script `.sh` à la racine n’existe. Pour lancer le jeu :

```bash
python3 src/main.py
```

> **Note** : Assurez-vous d’avoir installé Pygame (`pip install pygame`) avant de lancer le jeu.

## 5. **Contrôles borne**

D'après le fichier `bouton.txt` :

- **Joystick** (flèches) : Déplacement gauche/droite du canon.
- **Touche R** (X) : Gauche et droite.
- **Touche T** (Y) : Interagir.
- **Touche F** (A) : Retour.
- Les autres touches ne sont pas utilisées.
