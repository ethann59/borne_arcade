# Tron Arcade Game

## **Description**

Jeu de type *Tron* inspiré du style rétro, conçu pour une borne d'arcade. Le but est de faire tomber l'adversaire en évitant les collisions avec les traînées des joueurs. Le jeu se joue à deux avec des contrôleurs physiques (joysticks et boutons). Le gameplay est intense et rapide, avec un style visuel rétro et des effets de glow pour les traînées.

## **Stack technique**

- **Langage** : Python 3.x
- **Librairie principale** : `pygame`
- **Système d'exploitation** : Compatible Linux (à partir d'un script `.sh` à la racine)

## **Structure principale**

- `tron.py` : Point d'entrée du jeu, gestion du cycle de vie.
- `game.py` : Logique principale du jeu, boucle de jeu, gestion des joueurs et collisions.
- `player.py` : Classe `Player` avec traînée, déplacement et dessin.
- `direction.py` : Enumération des directions.
- `config.py` : Constantes globales (taille grille, couleurs, délais).
- `options.py` : Menu d'options avec changement de difficulté, vitesse et son.
- `menu.py` : Menu principal avec navigation.
- `utils.py` : Fonctions utilitaires (dessin de grille, effets, etc.).
- `description.txt` : Texte de description du jeu.
- `bouton.txt` : Configuration des boutons de la borne d'arcade.

## **Installation / lancement**

Un script `.sh` à la racine permet de lancer le jeu :

```bash
./run.sh
```

Assurez-vous que `pygame` est installé :

```bash
pip install pygame
```

## **Contrôles borne**

Le fichier `bouton.txt` est vide — les contrôles sont définis dans le code :

- **Joystick J1** (flèches) : Déplacement du joueur 1.
- **Joystick J2** (O/K/L/M) : Déplacement du joueur 2.
- **Touche R** (J1 X) : Sélection / confirmation.
- **Touche F** (J1 A) : Retour au menu.
