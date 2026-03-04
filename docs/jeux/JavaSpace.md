# JavaSpace : Un Jeu de Tir Spatial

## Description du Jeu

JavaSpace est un jeu de tir spatial où le joueur contrôle un vaisseau spatial et doit détruire des ennemis avant qu'ils ne le détruisent. Le jeu se déroule dans un espace infini, et le joueur doit utiliser ses armes pour infliger des dégâts aux ennemis. Le but est de survivre le plus longtemps possible et de détruire le plus d'ennemis possible. Le gameplay est basé sur le contrôle du vaisseau avec des touches directionnelles, le tir sur les ennemis et la gestion des ressources (vie, munitions).

## Architecture Technique

Le jeu est structuré autour de plusieurs classes principales :

*   **`Jeu`**: La classe principale qui gère le jeu, la logique, les événements, et l'interaction entre les différentes parties du jeu. Elle contient les méthodes pour l'avancement du jeu, la gestion des joueurs et des ennemis, et la gestion des collisions.
*   **`Ennemi`**: Représente un ennemi dans le jeu, avec des attributs tels que sa position, sa vie, ses armes, et ses méthodes pour se déplacer et attaquer.
*   **`Tir`**: Représente un tir effectué par le joueur ou un ennemi, avec des attributs tels que sa position, sa direction, son dégât, et ses méthodes pour se déplacer et infliger des dégâts.
*   **`Main`**: La classe principale qui exécute le jeu, gère le cycle de jeu (boucle principale), et interagit avec la classe `Jeu`.
*   **`ClavierBorneArcade`**:  Une classe utilitaire qui gère les entrées clavier, simplifiant le contrôle du vaisseau.

Le jeu utilise la bibliothèque MG2D pour la gestion des graphiques et des animations.

## Installation et Dépendances

1.  **Télécharger MG2D:**  [https://mg2d.github.io/](https://mg2d.github.io/)
2.  **Créer un projet Java:** Utilisez un IDE comme IntelliJ IDEA ou Eclipse.
3.  **Ajouter la bibliothèque MG2D:** Importez la bibliothèque MG2D dans votre projet.  Suivez les instructions spécifiques à votre IDE.
4.  **Copier les fichiers source:**  Copiez les fichiers source Java (Jeu.java, Main.java, Tir.java) dans le répertoire de votre projet.
5.  **Compiler et exécuter:** Compilez et exécutez le programme Java.

## Utilisation

*   **Contrôles du Vaisseau:**
    *   **Flèches Gauche/Droite:** Déplacent le vaisseau horizontalement.
    *   **Flèche Haut/Bas:** Déplacent le vaisseau verticalement.
    *   **Espace:** Tire sur l'ennemi.
*   **Objectifs du Jeu:**
    *   Détruire tous les ennemis.
    *   Survie du vaisseau le plus longtemps possible.

## Structure des Fichiers

```
JavaSpace/
├── Jeu.java
├── Main.java
├── Tir.java
└── MG2D/
    ├── ... (dossiers et fichiers MG2D)
```

Note : Les fichiers MG2D et leurs dépendances ne sont pas inclus ici, car la documentation se concentre sur la structure et l'utilisation du code Java.
