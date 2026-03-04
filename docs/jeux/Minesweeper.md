# Minesweeper - Jeu de Déduction et de Stratégie

## Description du jeu

Minesweeper est un jeu de déduction et de stratégie où l'objectif est de révéler tous les champs vides (non contigués à des mines) sur une grille. Chaque champ révèle le nombre de mines adjacentes. En analysant ces informations, le joueur doit déduire la position des mines et révéler avec succès tous les champs vides.  Le jeu est basé sur la déduction logique et la planification stratégique.

## Architecture technique

Le jeu est structuré autour des classes suivantes :

*   **`Game`**: La classe principale qui gère l'état du jeu, la logique du jeu, et l'interface utilisateur. Elle contient la grille, le compteur de mines, et gère les actions du joueur.
*   **`Grid`**:  Représente la grille de jeu.  Elle gère l'allocation des mines et la création des champs vides.
*   **`Tile`**: Représente un seul champ de la grille.  Elle contient des informations sur son état (vide, mine, nombre de mines adjacentes), et gère les actions de clic.
*   **`Constants`**: Contient des constantes utilisées dans le jeu, telles que les dimensions de la grille, la taille des tuiles et le nombre de mines.
*   **`Difficulty`**: Classe qui gère les différentes difficultés du jeu (Easy, Medium, Hard), ajustant le nombre de mines et la taille de la grille en conséquence.

Le code est organisé en modules pour la clarté et la maintenabilité.  L'utilisation de classes et d'objets permet une conception orientée objet, facilitant l'extension et la modification du jeu.

## Installation et dépendances

1.  **Télécharger le code source :**  Téléchargez le code source du jeu à partir de la source.
2.  **Compilateur :** Assurez-vous que vous avez un compilateur Java installé (par exemple, JDK).
3.  **IDE (Optionnel) :** Utilisez un IDE (Integrated Development Environment) comme IntelliJ IDEA, Eclipse, ou NetBeans pour faciliter le développement et le débogage.
4.  **Exécuter :** Exécutez le fichier exécutable Java généré.

Aucune dépendance externe n'est requise, car le code est écrit en Java et ne nécessite pas d'autres bibliothèques ou frameworks.

## Utilisation

*   **Démarrer le jeu :** Exécutez le fichier exécutable Java.
*   **Contrôles du jeu :**
    *   **Clic gauche :** Révèle le champ sur lequel vous cliquez. Si le champ contient une mine, le jeu se termine. Sinon, il révèle le nombre de mines adjacentes.
    *   **Clic droit :** Marque le champ comme mine.  Vous pouvez marquer plusieurs champs comme mines.
    *   **Recherche de la fin de partie:** Le jeu se termine lorsque tous les champs vides sont révélés et que toutes les mines ont été marquées.
*   **Stratégies:**
    *   Commencez par révéler les champs voisins des bords de la grille.
    *   Utilisez les nombres affichés sur les champs pour déduire la position des mines.
    *   Marquez les champs comme mines si vous ne pouvez pas les révéler sans risque.

## Structure des fichiers

```
Minesweeper/
├── Constants.java
├── ConstanteEasy.java
├── ConstanteHard.java
├── ConstanteMedium.java
├── Game.java
├── Grid.java
├── Tile.java
├── Difficulty.java
└── Main.java
```

*   `Constants.java`: Contient des constantes utilisées dans le jeu.
*   `ConstanteEasy.java`, `ConstanteHard.java`, `ConstanteMedium.java`:  Contient des constantes spécifiques aux différents niveaux de difficulté.
*   `Game.java`: La classe principale du jeu.
*   `Grid.java`: Représente la grille du jeu.
*   `Tile.java`: Représente un seul champ de la grille.
*   `Difficulty.java`: Gère les différents niveaux de difficulté.
*   `Main.java`: Le point d'entrée du programme.
