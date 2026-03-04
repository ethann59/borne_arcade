# Kowasu_Renga - Documentation Technique

## 1. Description du Jeu

**Objectif:** Kowasu_Renga est un jeu d'arcade où le joueur contrôle une raquette pour dévier une balle et détruire des blocs colorés.  Le but est d'atteindre un score élevé en détruisant le plus de blocs possible avant de perdre toutes ses vies.

**Règles:**

*   Le joueur contrôle une raquette qui se déplace horizontalement.
*   Une balle est lancée aléatoirement et le joueur doit la dévier avec sa raquette.
*   Si la balle touche un bloc coloré, le bloc est détruit et le score du joueur augmente.
*   Si la balle touche le sol ou le plafond, elle est renvoyée.
*   Le joueur perd une vie si la balle touche la raquette.
*   Le jeu se termine lorsque le joueur épuise toutes ses vies.

**Gameplay:** Le gameplay est basé sur la précision et la coordination. Le joueur doit anticiper le mouvement de la balle et ajuster la position de sa raquette pour la dévier vers les blocs.  La difficulté augmente avec l'apparition de nouveaux blocs et un rythme de balle plus rapide.

## 2. Architecture Technique

**Structure du Code:**

Le code est structuré autour de la classe principale `Kowasu_Renga`, qui gère l'ensemble du jeu.  Cette classe utilise la bibliothèque MG2D pour le rendu graphique et la gestion des événements.  Le jeu est divisé en plusieurs sections :

*   **Initialisation:**  Configuration des paramètres du jeu, création des objets graphiques, et gestion des entrées clavier.
*   **Mise à Jour:**  Mise à jour de la position de la balle, de la raquette, et des blocs.
*   **Rendu:**  Dessin des objets graphiques à l'écran.
*   **Gestion des Événements:**  Traitement des entrées clavier (raquette, touches spéciales).

**Classes/Modules Principaux:**

*   `Kowasu_Renga`: Classe principale, gère le cycle de vie du jeu.
*   `ClavierBorneArcade`: Classe pour la gestion des entrées clavier d'une borne d'arcade.
*   `FenetrePleinEcran`: Classe pour créer une fenêtre pleine écran.
*   `Cercle`: Classe pour représenter la balle.
*   `Rectangle`: Classe pour représenter la raquette et les blocs.
*   `Couleur`: Classe pour représenter les couleurs des blocs et de la raquette.
*   `Texture`: Classe pour charger et afficher des textures (images).
*   `Texte`: Classe pour afficher du texte à l'écran.

## 3. Installation et Dépendances

**Dépendances:**

*   **MG2D Library:**  Ce jeu dépend de la bibliothèque MG2D pour le rendu graphique et la gestion des événements.  Assurez-vous d'avoir installé la bibliothèque MG2D correctement dans votre environnement de développement Java.  Les instructions d'installation de MG2D peuvent être trouvées sur [https://mg2d.github.io/](https://mg2d.github.io/).

**Installation et Lancement:**

1.  **Compilation:** Compilez le code source Java (`Kowasu_Renga.java`) en utilisant un compilateur Java (par exemple, javac).
2.  **Exécution:** Exécutez le fichier JAR généré (`Kowasu_Renga.jar`) en utilisant la commande `java -jar Kowasu_Renga.jar`.

## 4. Utilisation

**Commandes et Contrôles de Jeu:**

*   **Direction Gauche:**  Appuyez sur la touche `gauche` (ou la touche correspondante sur votre contrôleur) pour déplacer la raquette vers la gauche.
*   **Direction Droite:** Appuyez sur la touche `droite` (ou la touche correspondante sur votre contrôleur) pour déplacer la raquette vers la droite.
*   **Toucher la balle:**  Utilisez la raquette pour dévier la balle et la faire entrer en collision avec les blocs.
*   **Quitter:** Appuyez sur la touche `J1` (ou la touche correspondante sur votre contrôleur) pour quitter le jeu.

## 5. Structure des Fichiers

```
Kowasu_Renga/
├── Kowasu_Renga.java       // Fichier principal du jeu
├── img/                   // Dossier contenant les images (background.jpg, 0.png, etc.)
│   ├── background.jpg
│   ├── 0.png
│   └── ...
└── font.ttf             // Fichier de police TrueType (si disponible)
```
