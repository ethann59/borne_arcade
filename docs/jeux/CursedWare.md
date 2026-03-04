# CursedWare

## Description

`CursedWare` est une collection de mini-jeux en Lua/LÖVE, inspirée de WarioWare, avec score global et rythme rapide.

## Stack technique

- Langage : Lua
- Framework : LÖVE (Love2D)
- Entrée principale : `projet/CursedWare/main.lua`

## Structure principale

- `projet/CursedWare/main.lua` : configuration de la fenêtre et boucle LÖVE
- `projet/CursedWare/src/classes/` : primitives/classes utilitaires
- `projet/CursedWare/src/libs/` : services utilitaires (input, tween, timing…)
- `projet/CursedWare/src/screens/` : écrans du jeu (title, sélection, pause, score…)
- `projet/CursedWare/minigames/*/game.lua` : mini-jeux
- `projet/CursedWare/assets/` : polices, sons, musiques, images

## Installation / lancement

Depuis la racine du projet :

```bash
./CursedWare.sh
```

ou manuellement :

```bash
cd projet/CursedWare
love .
```

## Contrôles

Les contrôles varient selon le mini-jeu actif.
La configuration borne de base est stockée dans `projet/CursedWare/bouton.txt`.
