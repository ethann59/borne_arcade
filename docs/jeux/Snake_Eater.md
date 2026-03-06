# Snake Game - Documentation Mini

## 1. Description

Jeu de type Snake développé pour une borne d'arcade, où le joueur contrôle un serpent à l’aide d’un joystick pour collectionner des pommes. Le jeu se termine si le serpent touche les bords ou lui-même. Le but est d'obtenir le meilleur score possible.

Le jeu est conçu pour un environnement de borne d'arcade, avec des contrôles via joystick et boutons physiques. Il intègre un système de sauvegarde des meilleurs scores.

## 2. Stack technique

- **Langage** : Java
- **Librairie principale** : MG2D (outil de développement graphique pour l'enseignement)
- **Environnement** : Borne d'arcade avec interface joystick et boutons

## 3. Structure principale

- `SnakeGame.java` : Classe principale du jeu
- `Serpent.java` : Gestion du serpent (déplacement, croissance)
- `Nourriture.java` : Gestion des pommes à collecter
- `Pomme.java` : Représentation d’une pomme
- `HighScore.java` : Gestion du système de sauvegarde des meilleurs scores
- `LigneHighScore.java` : Représentation d’une entrée de high score
- `Fenetre.java` : Interface graphique (fournie par MG2D)
- `Point.java` : Représentation d’un point dans l’espace
- `Carre.java` : Représentation d’un carré (utilisé pour les éléments graphiques)
- `Couleur.java` : Définition des couleurs

## 4. Installation / lancement

Aucun script `.sh` à la racine n’est fourni. Le projet est à compiler et exécuter manuellement à partir d’un environnement Java. Les classes doivent être compilées avec un compilateur Java, et l’exécutable peut être lancé via la commande :

```bash
java SnakeGame
```

Assurez-vous que la librairie MG2D soit disponible dans le classpath.

## 5. Contrôles borne

D'après le fichier `bouton.txt` :

- **Joystick** (flèches) : Déplacement du serpent (haut, bas, gauche, droite).
- **Touche Y** (Z) : Quitter.
- Les autres touches ne sont pas utilisées.
