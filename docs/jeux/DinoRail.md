# DinoRail

## Description

DinoRail est un jeu développé par DUFEUTREL Thibaut (2025), inspiré du célèbre jeu du dinosaure de Google Chrome. Le joueur contrôle un dinosaure qui doit sauter ou s'accroupir pour éviter les obstacles. Développé avec la bibliothèque MG2D.

Crédits sonores : cabled_mess (son de saut), JuanD20 (son d'accroupissement).

## Stack technique

- **Langage :** Java
- **Bibliothèque graphique :** MG2D (FenetrePleinEcran, Couleur, geometrie)
- **Résolution :** 1275×1020

## Structure principale

- `DinoRail.java` : Classe principale — fenêtre, boucle de jeu, gestion du dinosaure et du score
- `Obstacle.java` : Représentation et gestion des obstacles
- `ClavierBorneArcade.java` : Adaptation des contrôles pour la borne

## Installation / lancement

```bash
./DinoRail.sh
```

## Contrôles borne

| Contrôle | Action |
|----------|--------|
| Joystick | Mouvement du dinosaure (haut = saut, bas = accroupi) |
| Bouton 4 | Quitter |
