# Tron: Legacy

**Description du jeu:**

Tron: Legacy est un jeu d'arcade futuriste où le joueur contrôle un "disc" (disque) dans un labyrinthe complexe. L'objectif est de naviguer à travers le labyrinthe, collecter des points et éviter les obstacles et les autres joueurs (si le mode multijoueur est activé). Le jeu met l'accent sur la vitesse, la précision et la maîtrise du mouvement.

**Architecture technique:**

Le jeu est structuré en plusieurs modules principaux :

*   **`player.py`**: Définit la classe `Player`, qui gère le mouvement, la direction, la collision et l'affichage du joueur et de sa traînée.
*   **`direction.py`**: Définit la classe `Direction` qui représente les quatre directions possibles (haut, bas, gauche, droite) et leurs valeurs correspondantes.
*   **`config.py`**: Contient les constantes et les paramètres du jeu, tels que les couleurs, les dimensions de la grille, les délais de mouvement, etc.
*   **`main.py`**: Le point d'entrée du jeu, qui initialise le jeu, gère l'événementiel (gestion des entrées utilisateur et des événements du jeu), et affiche le jeu.
*   **`grid.py`**: (Non inclus dans les extraits fournis) Gère la création et la manipulation de la grille du jeu.

Le jeu utilise une architecture orientée objet pour organiser le code et faciliter la maintenance et l'extension.  Les classes interagissent entre elles pour gérer les différents aspects du jeu.

**Installation et dépendances:**

*   **Dépendances:** Pygame (version 2.0 ou supérieure)
*   **Installation:**
    1.  Assurez-vous que Pygame est installé : `pip install pygame`
    2.  Clonez le dépôt du projet.
    3.  Assurez-vous que Python 3 est installé.
    4.  Exécutez `main.py` depuis la ligne de commande.

**Utilisation:**

*   **Contrôles de jeu:**
    *   **Flèches gauche/droite:** Déplacent le joueur dans la direction correspondante.
    *   **Flèche haut:**  Fait pivoter le joueur de 90 degrés dans le sens horaire.
    *   **Flèche bas:** Fait pivoter le joueur de 90 degrés dans le sens anti-horaire.
    *   **Entrée (Enter):** Sélectionne/désélectionne le joueur (pour l'effet de glow).
    *   **Échap (Escape):** Quitte le jeu.

**Structure des fichiers:**

Le code est organisé dans les fichiers suivants :

*   `config.py`: Contient les constantes du jeu (couleurs, dimensions, etc.).
*   `direction.py`: Définit la classe `Direction`.
*   `grid.py`: (Non inclus, gère la grille du jeu)
*   `main.py`: Le fichier principal du jeu.
*   `player.py`: Définit la classe `Player`.
