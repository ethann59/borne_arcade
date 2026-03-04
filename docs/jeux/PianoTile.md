# PianoTile

## Description

PianoTile est une adaptation du célèbre jeu de piano développée par GUILBERT Emma (2025). Des tuiles défilent à l'écran et le joueur doit appuyer sur les bonnes colonnes au bon moment, le tout accompagné de musiques exceptionnelles.

## Stack technique

- **Langage :** Python
- **Bibliothèques :** Pygame, librosa (analyse audio)
- **Dépendances :** `requirements.txt` (pygame, librosa)

## Structure principale

- `app/game.py` : Point d'entrée — orchestrateur (Database, Interface, Logic)
- `app/project.py` : Configuration du projet
- `core/logic.py` : Logique de jeu (651 lignes — gestion des tuiles, couleurs, score)
- `core/button.py` : Gestion des boutons
- `core/player.py` : Profil joueur
- `core/pageState.py` : Machine à états des écrans
- `ui/interface.py` : Interface graphique principale
- `ui/layout/`, `ui/manager/`, `ui/page/`, `ui/utils/` : Composants UI (architecture MVC)
- `data/database.py` : Persistance des données (scores, paramètres)
- `assets/` : Ressources (musiques, images)

## Installation / lancement

```bash
./PianoTile.sh
```

## Contrôles borne

| Contrôle | Action |
|----------|--------|
| Bouton 1 | Colonne 1 (touches R/A) |
| Bouton 2 | Colonne 2 (touches T/Z) |
| Bouton 3 | Colonne 3 (touches Y/E) |
| Bouton 4 | Colonne 4 (touches F/Q) |
| Bouton 6 | Valider (touches H/D) |
