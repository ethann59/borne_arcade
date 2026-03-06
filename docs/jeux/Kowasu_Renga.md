# Documentation du Jeu Arcade

## 1. Description
Ce jeu est un **casse-brique** (breakout) conçu pour une **borne d'arcade**. L'objectif est de faire rebondir une balle pour casser tous les blocs disposés en forme de pyramide. Le joueur utilise un **joystick** pour déplacer une raquette en bas de l'écran et un **bouton A** pour lancer la balle. Le jeu est une adaptation simple et directe du genre de jeu classique, adapté au contexte de la borne avec des contrôles physiques spécifiques.

## 2. Stack technique
- **Langage** : Java
- **Librairie principale** : `MGD2` 
- **Environnement** : Exécution sur borne d'arcade (contrôles joystick + boutons)

## 3. Structure principale
- `Kowasu_Renga.java` : Fichier principal contenant la logique du jeu, les initialisations, les boucles de jeu et les contrôles.
- `Tests.java` : Fichier contenant les tests unitaires pour les classes du jeu (Clavier, Fenêtre, Cercle, Rectangle, etc.)
- `bouton.txt` : Définit les contrôles de la borne.
- `description.txt` : Fournit une description du jeu et de son contexte.

## 4. Installation / lancement
Aucun script `.sh` à la racine n’est fourni, mais le projet peut être compilé et exécuté via un IDE Java ou via la ligne de commande :
```bash
javac *.java
java Kowasu_Renga
```

## 5. Contrôles borne

D'après le fichier `bouton.txt` :

- **Joystick** (flèches) : Déplacement de la raquette (gauche/droite).
- **Touche Y** (Z) : Quitter.
- **Touche F** (A) : Lancer la balle.
- Les autres touches ne sont pas utilisées.
