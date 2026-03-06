# Mini Documentation du Jeu d'Arcade

## 1. Description

Ce jeu est un **jeu d'arcade en mode vertical shooter** (scrolling shooter), inspiré des classiques du genre. Le joueur contrôle un vaisseau spatial qui se déplace verticalement sur l'écran, et doit détruire des ennemis qui apparaissent en rafales depuis le haut de l'écran. Le but est d'obtenir le plus haut score possible en détruisant les ennemis et en évitant leurs attaques.

Le jeu est conçu pour fonctionner sur une **borne d'arcade**, avec un **joystick pour se déplacer** et des **boutons pour tirer et interagir** avec le jeu.

## 2. Stack technique

- **Langage** : Java
- **Librairie principale** : `MG2D` (bibliothèque graphique personnalisée pour les bornes d'arcade)
- **Tests** : JUnit 5

## 3. Structure principale

Fichiers et modules clés présents :

- `Jeu.java` : Point d'entrée du jeu, gère les états (menu, jeu, pause, fin).
- `Joueur.java` : Représente le vaisseau du joueur, gère les déplacements et le tir.
- `Ennemi.java` : Représente les ennemis, leurs comportements et trajectoires.
- `Boss.java` : Représente le boss final, avec des règles spécifiques.
- `Tir.java` : Représente les tirs du joueur et des ennemis.
- `Bonus.java` : Gère les objets bonus (vies, puissances, etc.).
- `Collision.java` : Gestion des collisions entre objets.
- `tests/Tests.java` : Tests unitaires pour les classes principales.

## 4. Installation / lancement

Aucun script `.sh` n’est fourni à la racine. Pour lancer le jeu :

1. Compiler les fichiers Java :
   ```bash
   javac *.java
   ```

2. Lancer le jeu :
   ```bash
   java Jeu
   ```

Assurez-vous que la bibliothèque `MG2D` est accessible dans le classpath.

## 5. Contrôles borne

D'après le fichier `bouton.txt` :

- **Joystick** (flèches) : Déplacement du vaisseau (horizontal et vertical).
- **Touche F** (A) : Tirer.
- Les autres touches ne sont pas utilisées.
