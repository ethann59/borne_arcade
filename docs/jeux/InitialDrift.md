# Documentation Jeu Arcade

## 1. Description

Jeu de type "dodge" sur une borne d'arcade, où le joueur doit éviter les ennemis qui apparaissent sur la route. Le joueur contrôle un véhicule à l'aide d'un joystick, et les ennemis sont générés aléatoirement. Le but est de survivre le plus longtemps possible.

Le jeu est conçu pour fonctionner sur une borne d'arcade avec des contrôleurs spécifiques (joysticks + boutons). Les interactions sont basées sur les boutons de la borne, conformément à la description du fichier `bouton.txt`.

## 2. Stack technique

- **Langage** : Java
- **Librairie principale** : MG2D (outil graphique fourni pour le projet)
- **Tests** : JUnit 5

## 3. Structure principale

- `InitialDrift/Jeu.java` : Classe principale du jeu, gère la logique de jeu, les générations d'ennemis et de décor.
- `InitialDrift/Joueur.java` : Représente le joueur avec ses interactions (contrôles, collisions).
- `InitialDrift/Ennemi.java` : Représente les ennemis avec leurs comportements (vitesse, déplacement, collisions).
- `InitialDrift/Main.java` : Point d'entrée du programme.
- `InitialDrift/tests/Tests.java` : Fichier de tests unitaires pour `Ennemi` et `Joueur`.

## 4. Installation / lancement

Aucun script `.sh` à la racine n’est fourni. Pour lancer le jeu, il faut compiler et exécuter les fichiers Java avec un environnement Java 11+.

```bash
javac InitialDrift/*.java
java InitialDrift.Main
```

## 5. Contrôles borne

D'après le fichier `bouton.txt` :

- **Joystick** (flèches) : Déplacement de la voiture.
- **Touche Y** (Z) : Quitter.
- Les autres touches ne sont pas utilisées.
