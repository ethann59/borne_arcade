# DinoRail - Documentation Technique

## 1. Description du Jeu

DinoRail est un jeu d'arcade où le joueur contrôle un dinosaure sur un rail en utilisant un clavier de borne d'arcade. L'objectif est de survivre le plus longtemps possible en évitant des obstacles (cactus et oiseaux) qui se déplacent le long du rail. Le jeu est basé sur un gameplay de plateforme simple avec un accent sur la précision et la réactivité.

## 2. Architecture Technique

Le jeu est écrit en Java et utilise la bibliothèque MG2D pour le rendu graphique et la gestion des événements. L'architecture principale est divisée en plusieurs classes et modules :

*   **ClavierBorneArcade:** Cette classe gère l'entrée clavier de la borne d'arcade. Elle implémente l'interface `KeyListener` pour détecter les pressions des touches et des boutons du joystick. Elle utilise des booléens pour indiquer l'état de chaque direction/bouton (enfoncé ou relâché).
*   **DinoRail:** C'est la classe principale du jeu. Elle gère la logique du jeu, la création des objets (joueur, obstacles), la gestion des collisions, le score, et l'affichage. Elle utilise les classes `ClavierBorneArcade` et `Obstacle`.
*   **Obstacle:** Cette classe représente un obstacle dans le jeu. Elle hérite de la classe `Texture` de MG2D pour gérer le chargement et l'affichage de l'image de l'obstacle.

## 3. Installation et Dépendances

**Prérequis :**

*   Java Development Kit (JDK) installé et configuré.
*   Bibliothèque MG2D : Assurez-vous que la bibliothèque MG2D est correctement installée et configurée dans votre environnement de développement.  La documentation MG2D fournit des instructions détaillées sur l'installation et la configuration.

**Étapes d'installation et de lancement :**

1.  Téléchargez le code source du jeu (DinoRail.java, ClavierBorneArcade.java, Obstacle.java).
2.  Compilez le code source en utilisant un compilateur Java (par exemple, `javac DinoRail.java`).
3.  Exécutez le fichier exécutable généré (par exemple, `java DinoRail`).  Le jeu devrait démarrer dans une fenêtre.

## 4. Utilisation

**Commandes et Contrôles :**

*   **Joystick 1:**
    *   **Haut:**  Appuyez sur le joystick vers le haut pour faire sauter le dinosaure.
    *   **Bas:** Appuyez sur le joystick vers le bas pour faire descendre le din<unused3595>.
    *   **Gauche/Droite:** Déplacer le dinosaure sur le rail.
*   **Boutons:**
    *   Les boutons peuvent être utilisés pour effectuer des actions spécifiques, telles que le saut (si configuré).

**Gameplay :**

*   Le joueur contrôle le dinosaure sur un rail.
*   Des obstacles (cactus et oiseaux) se déplacent le long du rail.
*   Le joueur doit éviter les obstacles pour survivre.
*   Le joueur peut sauter pour surmonter les obstacles.
*   Le jeu se termine si le dinosaure entre en collision avec un obstacle.

## 5. Structure des Fichiers

*   `DinoRail.java`:  La classe principale du jeu, gérant la logique du jeu, l'affichage et l'entrée utilisateur.
*   `ClavierBorneArcade.java`:  La classe gérant l'entrée clavier de la borne d'arcade.
*   `Obstacle.java`:  La classe représentant un obstacle dans le jeu.
*   `assets/img/cactus.png`:  Image de l'obstacle cactus.
*   `assets/img/bird.png`: Image de l'obstacle oiseau.
*   `assets/sound/jump.mp3`: (Optionnel) fichier audio pour le son de saut.
