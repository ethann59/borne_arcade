# Minesweeper

## Description

Minesweeper est une adaptation du célèbre jeu de démineur, développé par Mathilde Henrion et Johan Pezo (2025). Découvrez les cases sans faire exploser de mines. Plusieurs niveaux de difficulté (Easy, Medium, Hard) et thèmes visuels (Classic, Dark Classic) sont disponibles.

## Stack technique

- **Langage :** Java
- **Bibliothèque graphique :** MG2D (Fenetre, Couleur, geometrie)

## Structure principale

- `MainGraphic.java` : Point d'entrée graphique (246 lignes)
- `Minesweeper.java` : Logique principale du démineur
- `Board.java` : Plateau de jeu (grille de cases)
- `Tile.java` : Case individuelle (mine, vide, chiffre)
- `Bomb.java` : Gestion des mines
- `Button.java` : Boutons d'interface
- `Cursor.java` : Gestion du curseur
- `Menu.java` : Écran de menu
- `Score.java` / `ScoreData.java` : Gestion des scores
- `Level.java` / `Easy.java` / `Medium.java` / `Hard.java` : Niveaux de difficulté
- `Theme.java` / `Classic.java` / `DarkClassic.java` : Thèmes visuels
- `Dig.java` / `Flag.java` / `Empty.java` : Actions sur les cases
- `Constants.java` : Constantes partagées
- `ClavierBorneArcade.java` / `KeyboardArcade.java` : Contrôles borne

## Installation / lancement

```bash
./Minesweeper.sh
```

## Contrôles borne

| Contrôle | Action |
|----------|--------|
| Joystick | Déplacement du curseur |
| Bouton 1 | Quitter |
| Bouton 5 | Creuser (révéler une case) |
| Bouton 6 | Poser / retirer un drapeau |
| Bouton 7 | Valider (creuser) |
