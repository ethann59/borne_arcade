# Puissance X

## Description

Puissance X est une version paramétrable du célèbre Puissance 4, développée par Florentin Magniez (2018). Tout est configurable : nombre de joueurs (de 2 à 4), nombre de pions à aligner, et possibilité de jouer contre des IA.

## Stack technique

- **Langage :** Java
- **Bibliothèque graphique :** MG2D (Fenetre, geometrie)

## Structure principale

- `Main.java` : Point d'entrée — boucle de jeu à 60 FPS
- `GestionAffichage.java` : Gestion de l'affichage et des parties
- `Ecran.java` : Gestion de l'écran
- `Plateau.java` : Grille de jeu
- `Joueur.java` : Interface joueur
- `JoueurNormal.java` : Joueur humain
- `VraiIA.java` : Intelligence artificielle
- `ConfigurationPartie.java` : Paramétrage de la partie
- `GenerateurCouleur.java` : Attribution des couleurs aux joueurs
- `Rendu.java` / `PartieSprite.java` : Rendu graphique
- `Zone.java` / `Point.java` : Géométrie
- Menus : `MenuNbJoueur.java`, `MenuNbPionsAligne.java`, `MenuNbColonne.java`, `MenuNbLigne.java`, `MenuIA.java`, etc.

## Installation / lancement

```bash
./Puissance_X.sh
```

## Contrôles borne

| Contrôle | Action |
|----------|--------|
| Joystick | Placement du pion (choix de la colonne) |
| Bouton 1 | Valider (lâcher le pion) |
| Bouton 5 | Annuler |
