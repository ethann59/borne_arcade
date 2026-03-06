# Minesweeper Arcade

## Description

Jeu de démineur adapté pour une borne d'arcade, utilisant un clavier personnalisé avec des joysticks et des boutons pour le contrôle. Le jeu respecte les règles classiques du démineur : découvrir les cases sans exploser les bombes. Le contexte de la borne impose une interface simplifiée et une navigation intuitive avec les entrées physiques.

## Stack technique

- **Langage** : Java
- **Librairie principale** : MG2D (bibliothèque graphique fournie pour le projet)

## Structure principale

- `Minesweeper.java` : Point d'entrée du jeu, gestion de la fenêtre principale.
- `Grille.java` : Représente la grille de jeu avec ses cases et logique de jeu.
- `Case.java` : Modélise une case individuelle avec état (découverte, drapeau, bombe).
- `Clavier.java` : Gestion des entrées clavier et contrôles de la borne.
- `Constante*.java` : Constantes de configuration pour les niveaux (easy, medium, hard).
- `Theme.java` : Gestion du thème graphique (couleurs, images).
- `Menu.java` : Interface de menu pour sélectionner le niveau et les options.

## Installation / lancement

Aucun script `.sh` à la racine n'existe. Pour lancer le jeu :

1. Compiler les fichiers Java :
   ```bash
   javac *.java
   ```
2. Exécuter le programme principal :
   ```bash
   java Minesweeper
   ```

## Contrôles borne

D'après le fichier `bouton.txt` :

- **Joystick** (flèches) : Déplacement dans la grille.
- **Touche R** (X) : Quitter.
- **Touche F** (A) : Creuser.
- **Touche G** (B) : Poser/retirer un drapeau.
- **Touche H** (C) : Entrer/creuser.
