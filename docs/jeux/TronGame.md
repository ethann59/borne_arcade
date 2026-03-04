# TronGame

## Description

TronGame est un jeu inspiré des light cycles du film Tron. Chaque joueur laisse une traînée derrière lui et doit éviter de percuter les murs ou les traînées adverses. Le jeu supporte un mode IA configurable.

## Stack technique

- **Langage :** Python
- **Bibliothèque :** Pygame (>= 2.5.0)
- **Dépendances :** `requirements.txt` (pygame>=2.5.0)

## Structure principale

- `main.py` : Point d'entrée — classe `TronGame`, mode plein écran ou fenêtré
- `game_main.py` : Classe `Game` — logique de la partie
- `menu_main.py` : Classe `Menu` — écran de menu principal
- `options_main.py` : Écran d'options
- `player.py` : Gestion des joueurs
- `ai.py` : Intelligence artificielle
- `config.py` : Configuration globale (résolution, couleurs, etc.)
- `direction.py` : Gestion des directions
- `menu_item.py` / `option_item.py` : Éléments d'interface
- `score_screen.py` : Écran des scores
- `utils/` : Utilitaires

## Installation / lancement

```bash
./TronGame.sh
```

## Contrôles borne

Les contrôles ne sont pas définis dans le fichier `bouton.txt` de ce jeu. Les touches sont configurées directement dans le code (Pygame key events).
