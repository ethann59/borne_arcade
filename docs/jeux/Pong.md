# Pong

## Description

Pong est le premier jeu programmé avec la bibliothèque MG2D, développé par Rémi Synave (2013). Un jeu de Pong classique particulièrement bien codé, accompagné d'une musique entraînante. La balle accélère progressivement au fil de la partie.

## Stack technique

- **Langage :** Java
- **Bibliothèque graphique :** MG2D (FenetrePleinEcran, Couleur, geometrie)
- **Audio :** MG2D.audio (musique de fond et effets sonores)

## Structure principale

- `Main.java` : Point d'entrée — boucle de jeu, gestion de la vitesse
- `Pong.java` : Logique du jeu (403 lignes) — gestion de la barre, de la balle, des rebonds et de l'accélération progressive
- `ClavierBorneArcade.java` : Adaptation des contrôles pour la borne
- Ressources : `Tied_Up.mp3` (musique), `bip.mp3` (effet sonore), `img/` (textures)

## Installation / lancement

```bash
./Pong.sh
```

## Contrôles borne

| Contrôle | Action |
|----------|--------|
| Joystick | Déplacement de la barre (haut/bas) |
| Bouton 4 | Quitter |
| Bouton 5 | Lancer la balle |
