# PianoTile

## Description

`PianoTile` est un jeu de rythme Python avec interface multi-pages (menu, jeu, profil, statistiques), musiques et score.

## Stack technique

- Langage : Python
- Moteur : Pygame
- Entrée principale : `projet/PianoTile/app/game.py`

## Structure principale

- `projet/PianoTile/app/game.py` : boucle principale et orchestration
- `projet/PianoTile/core/` : logique métier (joueur, boutons, état de page)
- `projet/PianoTile/ui/` : interface et pages
- `projet/PianoTile/data/` : accès base locale (`database.db`)
- `projet/PianoTile/assets/` : polices et musiques

## Installation / lancement

Depuis la racine du projet :

```bash
./PianoTile.sh
```

ou manuellement :

```bash
cd projet/PianoTile
python3 app/game.py
```

## Contrôles

D’après `projet/PianoTile/bouton.txt` :

- Colonne 1 : `R` / `A`
- Colonne 2 : `T` / `Z`
- Colonne 3 : `Y` / `E`
- Colonne 4 : `F` / `Q`
- Valider : `H` / `D`
