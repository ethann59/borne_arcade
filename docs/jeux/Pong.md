# Documentation du Jeu d'Arcade

## 1. Description

Ce jeu est un **Pong** réimplémenté pour une **borne d'arcade**, avec un contrôle spécifique aux joysticks et boutons. Il implémente les mécaniques de base d’un jeu de ping-pong, avec deux joueurs contrôlés par des manettes distinctes. Le jeu est conçu pour fonctionner dans un environnement d'arcade, avec une interface graphique simple et des interactions directes via les entrées spécifiques à la borne.

## 2. Stack technique

- **Langage** : Java
- **Librairie principale** : `java.awt` pour l’affichage et les événements clavier
- **Framework** : Aucun framework externe utilisé, code natif avec `java.awt` et `javax.swing`
- **Environnement** : Exécution sur machine Linux/Windows avec Java 8+

## 3. Structure principale

Les fichiers clés présents dans le projet sont :

- `Pong.java` : Classe principale du jeu, gère la boucle de jeu et l'affichage.
- `Clavier.java` : Gestion des événements clavier pour les inputs du joueur.
- `Joueur.java` : Modélise un joueur avec ses contrôles et sa position.
- `Balle.java` : Représente la balle et ses règles de déplacement.
- `Fenetre.java` : Fenêtre principale de l’application.
- `Clavier.java` : Gestion des entrées clavier (joysticks/boutons).
- `Clavier.java` : Gestion des entrées clavier (joysticks/boutons).

## 4. Installation / lancement

Aucun script `.sh` n’est fourni à la racine. Pour lancer le jeu :

1. Compiler les fichiers Java :
   ```bash
   javac *.java
   ```
2. Exécuter le programme principal :
   ```bash
   java Pong
   ```

## 5. Contrôles borne

D'après le fichier `bouton.txt` :

- **Joystick J1** (flèches) : Déplacement de la barre.
- **Touche Y** (Z) : Quitter.
- **Touche F** (A) : Lancer la balle.
- Les autres touches ne sont pas utilisées.

> Mapping clavier borne : J1 Joystick = flèches, J1 X=R, Y=T, Z=Y, A=F, B=G, C=H. J2 Joystick = O/K/L/M, J2 X=A, Y=Z, Z=E, A=Q, B=S, C=D.
