# Ball Blast

## Description

`ball-blast` est un jeu d’arcade en Python où le joueur détruit des boules pour augmenter son score.

## Stack technique

- Langage : Python
- Moteur : Pygame
- Entrée principale : `projet/ball-blast/src/__main__.py`

## Structure principale

- `projet/ball-blast/src/game.py` : boucle et logique de partie
- `projet/ball-blast/src/menu.py` : menu principal
- `projet/ball-blast/src/player.py` : joueur/canon
- `projet/ball-blast/src/ball.py` : comportement des boules
- `projet/ball-blast/src/bullet.py` : projectiles
- `projet/ball-blast/src/constantes.py` : constantes globales
- `projet/ball-blast/assets/` : images et sons

## Installation / lancement

Depuis la racine du projet :

```bash
./ball-blast.sh
```

ou manuellement :

```bash
cd projet/ball-blast
python3 ./src
```

## Contrôles

D’après `projet/ball-blast/bouton.txt` :

- Déplacement : gauche / droite
- Les autres actions sont gérées dans le jeu/menu.
