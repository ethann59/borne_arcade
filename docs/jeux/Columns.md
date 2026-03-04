# Columns

## Description

Columns est un jeu de puzzle développé par Dorian Terlat (2020). Alignez trois gemmes de même couleur pour les faire disparaître. ATTENTION ÇA CLIGNOTE !

## Stack technique

- **Langage :** Java
- **Bibliothèque graphique :** MG2D (FenetrePleinEcran, Clavier)

## Structure principale

- `Main.java` : Point d'entrée — boucle de jeu, fenêtre plein écran
- `Partie.java` : Logique de la partie en cours
- `Menu.java` : Écran de menu
- `Puits.java` : Grille de jeu (le puits où tombent les gemmes)
- `Colone.java` : Colonne de gemmes en cours de descente
- `Gemme.java` : Représentation d'une gemme individuelle
- `Controles.java` : Gestion des entrées joueur
- `ClavierBorneArcade.java` : Adaptation des contrôles pour la borne

## Installation / lancement

```bash
./Columns.sh
```

## Contrôles borne

| Contrôle | Action |
|----------|--------|
| Joystick | Déplacement de la colonne |
| Bouton 4 | Quitter |
| Bouton 5 | Intervertir les gemmes |
