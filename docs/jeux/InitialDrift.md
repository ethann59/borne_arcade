# InitialDrift

## Description

InitialDrift est un jeu de conduite développé par Loan Caecke (2017). Le joueur doit rouler le plus loin possible en évitant les véhicules arrivant en sens inverse : voitures, chars et barils de pétrole. Le tout accompagné d'une musique entêtante.

## Stack technique

- **Langage :** Java
- **Bibliothèque graphique :** MG2D (Fenetre, geometrie)

## Structure principale

- `Main.java` : Point d'entrée — boucle de jeu principale, appel à `Jeu.AvancerUnPasDeTemps()`
- `Jeu.java` : Gestion de la fenêtre, génération du décor et des ennemis
- `Joueur.java` : Voiture du joueur (déplacement, collision)
- `Ennemi.java` : Véhicules ennemis (voitures, chars, barils)
- `ClavierBorneArcade.java` : Adaptation des contrôles pour la borne
- `decor/`, `img/`, `sons/` : Ressources graphiques et sonores

## Installation / lancement

```bash
./InitialDrift.sh
```

## Contrôles borne

| Contrôle | Action |
|----------|--------|
| Joystick | Déplacement de la voiture (gauche/droite) |
| Bouton 4 | Quitter |
