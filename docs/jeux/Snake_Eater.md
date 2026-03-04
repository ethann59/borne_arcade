# Snake Eater

## Description

Snake Eater est un Snake classique développé par l'équipe MG2D (2013). Mangez un maximum de pommes pour faire grandir votre serpent. Attention : si vous perdez trop rapidement, le jeu se moquera de vous !

## Stack technique

- **Langage :** Java
- **Bibliothèque graphique :** MG2D (FenetrePleinEcran, Couleur, geometrie)
- **Résolution :** 1275×1020 (grille de cases de 30px)

## Structure principale

- `Snake_Eater.java` : Classe principale (145 lignes) — fenêtre plein écran, boucle de jeu, gestion du serpent et du score
- `Serpent.java` : Logique du serpent (corps, déplacement, croissance)
- `Nourriture.java` : Gestion de la nourriture
- `Pomme.java` : Représentation d'une pomme
- `HighScore.java` / `LigneHighScore.java` : Gestion des meilleurs scores
- `ClavierBorneArcade.java` : Adaptation des contrôles pour la borne

## Installation / lancement

```bash
./Snake_Eater.sh
```

## Contrôles borne

| Contrôle | Action |
|----------|--------|
| Joystick | Direction du serpent (haut/bas/gauche/droite) |
| Bouton 4 | Quitter |
