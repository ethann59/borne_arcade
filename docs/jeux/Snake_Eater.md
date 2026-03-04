# Snake Eater - Jeu en Java

## Description du Jeu

Snake Eater est un jeu classique de Snake où le but est de manger le plus de pommes possible tout en évitant de se cogner contre ses propres corps ou les bords de l'écran. Le serpent se déplace automatiquement, et le joueur contrôle sa direction en utilisant les touches fléchées.  Chaque fois que le serpent mange une pomme, il s'allonge, et le jeu continue jusqu'à ce que le serpent se cogne contre lui-même ou les bords de l'écran.  Le jeu enregistre le score du joueur.

## Architecture Technique

Le jeu est structuré autour des classes suivantes :

*   **`Snake_Eater` (Classe principale)** : Gère le cycle de vie du jeu, la logique principale, et l'interface utilisateur.
*   **`FenetrePleinEcran` (Classe fenêtre)** :  Gère la fenêtre du jeu, y compris la taille, le fond, et le rendu graphique.  Utilise `MG2D` pour le rendu.
*   **`ClavierBorneArcade` (Classe de gestion des entrées)** :  Gère les entrées du clavier du joueur.
*   **`Serpent` (Classe du serpent)** :  Représente le serpent, gère son mouvement et sa position.
*   **`Nourriture` (Classe de la nourriture)** :  Représente les pommes, gère leur position et leur création.
*   **`Texte` (Classe de texte)** :  Gère l'affichage des textes à l'écran (score, messages, etc.).

L'architecture est basée sur un modèle orienté objet, où chaque composant du jeu est représenté par une classe.  Le jeu utilise la bibliothèque `MG2D` pour le rendu graphique, et la classe `ClavierBorneArcade` permet une gestion flexible des entrées.

## Installation et Dépendances

1.  **Télécharger le code source :** Copiez le code source de ce document dans un dossier.
2.  **Installer MG2D :** Téléchargez et installez la bibliothèque MG2D depuis [https://github.com/jgp-dev/MG2D](https://github.com/jgp-dev/MG2D). Assurez-vous que le dossier `lib` de MG2D est dans le même répertoire que le code source.
3.  **Compiler et exécuter :** Utilisez un compilateur Java (par exemple, JDK) pour compiler le code source.  Ensuite, exécutez le fichier `.jar` généré.

## Utilisation

1.  **Contrôles du jeu :**
    *   **Flèches gauche :** Déplace le serpent vers la gauche.
    *   **Flèches droite :** Déplace le serpent vers la droite.
    *   **Flèches haut :** Déplace le serpent vers le haut.
    *   **Flèches bas :** Déplace le serpent vers le bas.
    *   **[Z] :** Quitte le jeu.
2.  **Gameplay :**  Le serpent se déplace automatiquement.  Évitez de vous cogner contre votre propre corps ou les bords de l'écran.  Mangez les pommes pour vous étendre.

## Structure des Fichiers

*   `Snake_Eater.java`:  Le fichier principal du jeu, contenant la logique principale et l'interface utilisateur.
*   `FenetrePleinEcran.java`:  La classe qui gère la fenêtre du jeu.
*   `ClavierBorneArcade.java`:  La classe qui gère les entrées du clavier.
*   `Serpent.java`:  La classe qui représente le serpent.
*   `Nourriture.java`:  La classe qui représente les pommes.
*   `Texte.java`: La classe qui gère l'affichage des textes.
*   `HighScore.java`:  La classe qui gère l'enregistrement des scores.
*   `MG2D/`:  Le dossier contenant les fichiers de la bibliothèque MG2D.
