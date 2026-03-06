# Columns Arcade Game

## 1. Description

**Objectif :**  
Le joueur doit aligner horizontalement 3 ou plus gemmes de la même couleur dans une grille pour les faire disparaître. Le jeu se déroule sur une borne d'arcade avec deux joueurs possibles, chacun contrôlant une colonne de gemmes tombant dans une grille.

**Contexte borne :**  
Le jeu est conçu pour une borne d'arcade avec deux joysticks et plusieurs boutons. Les joueurs contrôlent leurs colonnes avec des commandes de déplacement et de rotation, en utilisant les boutons pour lâcher les gemmes.

## 2. Stack technique

- **Langage :** Java
- **Librairie principale :** MG (MG est une librairie graphique pour l'arcade, utilisée ici pour l'affichage et les interactions)
- **Tests :** JUnit 5

## 3. Structure principale

- `Partie.java` – Gestion globale du jeu, règles et logique de base.
- `Pile.java` – Implémentation d'une pile pour la gestion des colonnes.
- `Colonne.java` – Gestion des colonnes de gemmes.
- `Gemme.java` – Représentation d'une gemme avec couleur.
- `Pile.java` – Structure de données pour la gestion des colonnes.
- `Menu.java` – Interface de menu principal.
- `Columns.java` – Classe principale du jeu.
- `Pile.java` – Gestion des piles de colonnes.
- `tests/Tests.java` – Tests unitaires du jeu.

## 4. Installation / lancement

Aucun script `.sh` à la racine n’est fourni.  
Le projet peut être compilé et lancé via une commande standard Java :

```bash
javac *.java
java Columns
```

## 5. Contrôles borne

D'après le fichier `bouton.txt` :

- **Joystick J1** (flèches) : Déplacement de la barre.
- **Touche Y** (Z) : Quitter.
- **Touche F** (A) : Intervertir les gemmes.
- Les autres touches ne sont pas utilisées.
