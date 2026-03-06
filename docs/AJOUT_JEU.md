# Documentation pour l'ajout d'un nouveau jeu

## 📁 Structure des dossiers

Lors de l'ajout d'un nouveau jeu, il faut respecter la structure suivante :

```
projet/
└── NomDuJeu/
    ├── *.java (ou *.py, *.lua)    # Fichiers sources du jeu
    ├── description.txt             # Description affichée dans le menu
    ├── bouton.txt                  # Mapping des boutons de la borne
    ├── photo_small.png             # Miniature affichée dans le menu
    ├── highscore/                  # Dossier des scores (optionnel)
    └── img/ ou assets/             # Ressources graphiques (optionnel)
```

## 🧱 Fichiers obligatoires

### 1. Script de lancement

Créer un script de lancement nommé `NomDuJeu.sh` **à la racine du projet** (pas dans le dossier du jeu).

Exemple pour un jeu Java :
```bash
#!/bin/bash
cd "$(dirname "$0")"
cd projet/NomDuJeu
java -cp ".:../../MG2D/mg2d.jar" Main
```

Exemple pour un jeu Python :
```bash
#!/bin/bash
cd "$(dirname "$0")"
cd projet/NomDuJeu
python3 main.py
```

Exemple pour un jeu Lua/LÖVE :
```bash
#!/bin/bash
cd "$(dirname "$0")"
love projet/NomDuJeu
```

Ce script doit :
- Se positionner dans le dossier du jeu
- Exécuter le jeu avec les bonnes dépendances

### 2. Fichier `description.txt`

Créer un fichier `description.txt` dans le dossier du jeu. Ce texte est affiché dans le menu de sélection de la borne.

### 3. Fichier `bouton.txt`

Créer un fichier `bouton.txt` décrivant le rôle de chaque bouton. Le format est une ligne avec les rôles séparés par `:` :

```
Mouvement:BoutonR:BoutonT:BoutonY:BoutonF:BoutonG:BoutonH
```

Mettre `aucun` pour les boutons non utilisés.

### 4. Image miniature

Ajouter un fichier `photo_small.png` pour l'affichage dans le menu de sélection.

### 5. Documentation et tests (générés automatiquement)

Les fichiers suivants sont générés automatiquement par `generate_docs_and_tests.py` :

- `DOCUMENTATION.md` : documentation technique du jeu
- Pour Java : `tests/Tests.java` (JUnit 5)
- Pour Python : `test.py` (pytest)
- Pour Lua : `test.lua` (busted)

## 🎮 Intégration au menu

Le menu graphique (`Graphique.java`) **découvre automatiquement** les jeux présents dans le dossier `projet/`. Il n'y a pas besoin de modifier le code du menu.

Il suffit que le dossier du jeu contienne les fichiers `description.txt`, `bouton.txt` et `photo_small.png` pour être correctement affiché.

## 🛠️ Compilation

### 1. Jeux Java

Pour les jeux Java, ajouter la compilation dans le script global `compilation.sh`. Le script détecte MG2D et compile chaque jeu avec le classpath approprié.

Les fichiers `.java` sont placés directement dans le dossier du jeu (pas de sous-dossier `src/` ni `build/`).

### 2. Jeux Python / Lua

Aucune compilation nécessaire. S'assurer que les dépendances sont installées (Pygame, LÖVE, etc.).

## ✅ Checklist de validation

### Avant de valider l'ajout :

1. [ ] Le dossier `projet/NomDuJeu/` existe
2. [ ] Le script `NomDuJeu.sh` est créé **à la racine** et exécutable (`chmod +x`)
3. [ ] Le fichier `description.txt` est rempli
4. [ ] Le fichier `bouton.txt` est rempli
5. [ ] Le fichier `photo_small.png` est présent
6. [ ] Le jeu compile correctement (si Java)
7. [ ] Le jeu s'exécute sans erreur via `./NomDuJeu.sh`
8. [ ] Le jeu est visible dans le menu principal (relancer la borne)
9. [ ] La documentation peut être générée via `./generate_docs.sh NomDuJeu`

## 📌 Exemple concret : Ajout d'un jeu Java `Pong`

### Structure

```
borne_arcade/
├── Pong.sh                     # Script de lancement (à la racine)
└── projet/
    └── Pong/
        ├── Main.java
        ├── Pong.java
        ├── ClavierBorneArcade.java
        ├── description.txt
        ├── bouton.txt
        ├── photo_small.png
        ├── img/
        ├── DOCUMENTATION.md      # Généré par l'IA
        └── tests/
            └── Tests.java        # Généré par l'IA
```

### Script de lancement `Pong.sh` (à la racine)

```bash
#!/bin/bash
cd "$(dirname "$0")"
cd projet/Pong
java -cp ".:../../MG2D/mg2d.jar" Main
```

### Fichier `bouton.txt`

```
Déplacement barre:rien:rien:Quitter:Lancer la balle:rien:rien
```

### Fichier `description.txt`

```
Jeu de type Pong classique avec deux raquettes et une balle.
Le premier joueur à atteindre 10 points gagne.
```
