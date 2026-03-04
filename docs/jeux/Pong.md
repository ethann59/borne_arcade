# Pong

## Description

`Pong` est une adaptation Java/MG2D du jeu de tennis de table arcade.

## Stack technique

- Langage : Java
- Bibliothèque graphique : MG2D
- Entrée principale : `projet/Pong/Main.java`

## Structure principale

- `projet/Pong/Main.java` : point d’entrée
- `projet/Pong/Pong.java` : logique du jeu
- `projet/Pong/ClavierBorneArcade.java` : gestion des entrées borne
- `projet/Pong/img/` : ressources visuelles
- `projet/Pong/tests/Tests.java` : tests associés

## Installation / lancement

Depuis la racine du projet :

```bash
./Pong.sh
```

Le script configure le classpath avec `MG2D` et exécute `Main`.

## Contrôles

D’après `projet/Pong/bouton.txt` :

- Déplacement de la barre : joystick
- Lancer la balle : bouton dédié
- Quitter : bouton dédié
