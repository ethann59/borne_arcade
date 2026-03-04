# JavaSpace

## Description

JavaSpace est un shoot'em up développé par Nicolas Choquet (2017). Revivez les aventures du jeune Luke Skywalker en approche de l'étoile de la mort. Détruisez vos adversaires et affrontez le boss final. (Note : le passage de l'étoile de la mort n'a pas été codé.)

## Stack technique

- **Langage :** Java
- **Bibliothèque graphique :** MG2D (Fenetre, geometrie)

## Structure principale

- `Main.java` : Point d'entrée — boucle de jeu, gestion des états (menu, jeu, fin)
- `Jeu.java` : Logique de jeu, gestion des vagues d'ennemis et du boss
- `Joueur.java` : Vaisseau du joueur (déplacement, vie)
- `Ennemi.java` : Vaisseaux ennemis
- `Boss.java` : Boss de fin de niveau
- `Tir.java` : Projectiles (joueur et ennemis)
- `Bonus.java` : Objets bonus récupérables
- `ClavierBorneArcade.java` : Adaptation des contrôles pour la borne

## Installation / lancement

```bash
./JavaSpace.sh
```

## Contrôles borne

| Contrôle | Action |
|----------|--------|
| Joystick | Déplacement du vaisseau |
| Bouton 5 | Tirer |
