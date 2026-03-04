# CursedWare

## Description

CursedWare est un clone de WarioWare développé par AERNOUTS, VERBRUGGHE, LINEZ et KHALIL (2022). Le jeu propose une série de mini-jeux rapides à enchaîner avant le temps imparti. Jouable à 2 joueurs, l'objectif est d'obtenir le meilleur score en réussissant un maximum de mini-jeux.

## Stack technique

- **Langage :** Lua
- **Bibliothèque principale :** LÖVE2D (Love2D)
- **Autres :** Instance, Classic (bibliothèques Lua pour LÖVE2D)

## Structure principale

- `main.lua` : Point d'entrée — initialisation, boucle de jeu, gestion des événements
- `conf.lua` : Configuration LÖVE2D (taille fenêtre, etc.)
- `src/` : Code source des classes (Vector2, Color, Rect, Image, Quad, etc.)
- `minigames/` : Dossier contenant les mini-jeux individuels
- `assets/` : Ressources graphiques et sonores

## Installation / lancement

```bash
./CursedWare.sh
```

Le script `CursedWare.sh` à la racine du projet gère le lancement via LÖVE2D.

## Contrôles borne

- **Joystick :** Aucun mouvement dédié
- **Bouton Interagir :** Action dans les mini-jeux
- **Bouton Retour :** Aucun
