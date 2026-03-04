# OsuTile

## Description

`OsuTile` est un jeu de rythme Python inspiré d’osu!mania : le joueur valide des notes sur des lanes en suivant la musique.

## Stack technique

- Langage : Python
- Moteur : Pygame
- Entrée principale : `projet/OsuTile/main.py`

## Particularité du projet

Au lancement, `main.py` génère automatiquement les maps Python (`projet/OsuTile/maps/*.py`) à partir des beatmaps `.osu` présentes dans `projet/OsuTile/beatmaps/` via `projet/OsuTile/tools/export_map.py`.

## Structure principale

- `projet/OsuTile/main.py` : bootstrap du jeu + génération des maps
- `projet/OsuTile/menu.py` : menu
- `projet/OsuTile/game.py` : gameplay
- `projet/OsuTile/map_parser.py` : parsing des beatmaps
- `projet/OsuTile/tile.py` : logique des notes/tiles
- `projet/OsuTile/assets/` : musique
- `projet/OsuTile/beatmaps/` : fichiers `.osu`

## Installation / lancement

Depuis la racine du projet :

```bash
./OsuTile.sh
```

ou manuellement :

```bash
cd projet/OsuTile
python3 main.py
```

## Contrôles

D’après `projet/OsuTile/bouton.txt` :

- Lane 1 : `R`
- Lane 2 : `T`
- Lane 3 : `Y`
- Pause : `F`
- Sélectionner / reprendre : `G`
- Quitter : `H`
