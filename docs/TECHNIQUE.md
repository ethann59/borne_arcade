# Documentation Technique - Borne d'Arcade Pédagogique

## 1. Architecture du projet

Le projet **borne_arcade** est une borne d'arcade pédagogique développée dans le cadre d'un projet tutoré à l'IUT du Littoral Côte d'Opale. Il permet de lancer plusieurs jeux en mode 2 joueurs, avec un clavier arcade spécifique et une interface de sélection de jeux.

### 1.1 Composants principaux

- **Jeux** : Implémentations de jeux variés (Java, Python, Lua)
- **Scripts de lancement** : Scripts shell pour exécuter chaque jeu
- **Interface de sélection** : Menu permettant de choisir un jeu
- **Clavier arcade** : Configuration spéciale pour les entrées utilisateur
- **Système de compilation** : Scripts pour compiler les jeux Java

### 1.2 Structure du projet

```
borne_arcade/
├── README.md
├── Main.java                  # Point d'entrée Java du menu
├── Graphique.java             # Interface graphique de sélection des jeux
├── ClavierBorneArcade.java    # Gestion du clavier arcade
├── Pointeur.java              # Pointeur de sélection dans le menu
├── Bouton.java                # Représentation d'un jeu dans le menu
├── Boite*.java                # Composants d'affichage (sélection, image, description)
├── HighScore.java             # Gestion des meilleurs scores
├── borne                      # Layout XKB personnalisé pour le clavier arcade
├── borne.desktop              # Fichier de démarrage automatique
├── lancerBorne.sh             # Script principal de démarrage
├── game_wrapper.sh            # Wrapper réappliquant le layout clavier
├── compilation.sh             # Compilation de MG2D et des jeux Java
├── *.sh                       # Scripts de lancement par jeu
├── test_ollama.py             # Test de connexion Ollama
├── generate_docs_and_tests.py # Générateur IA de docs et tests
├── ollama_wrapper_iut.py      # Wrapper Python pour l'API Ollama
├── docs/                      # Documentation MkDocs
├── projet/                    # Dossiers des jeux (un sous-dossier par jeu)
├── MG2D/                      # Bibliothèque graphique MG2D (mg2d.jar)
├── fonts/                     # Polices d'affichage
├── img/                       # Images du menu
└── sound/                     # Musiques de fond du menu
```

## 2. Scripts clés

### 2.1 Scripts de lancement

- **lancerBorne.sh** : Script principal de démarrage de la borne
- **game_wrapper.sh** : Wrapper pour lancer les jeux avec les bonnes configurations
- **[NomDuJeu].sh** : Scripts individuels pour chaque jeu (ex. `JavaSpace.sh`, `Pong.sh`)

### 2.2 Scripts d'installation et de génération

- **test_ollama.py** : Test de connexion au serveur Ollama
- **generate_docs.sh** : Script pour générer la documentation et les tests pour un ou tous les jeux
- **generate_docs_and_tests.py** : Script Python principal pour la génération de documentation
- **compilation.sh** : Script de compilation des jeux Java

## 3. Pipeline de compilation

### 3.1 Compilation des jeux Java

Les jeux Java sont compilés via le script `compilation.sh`. Ce script :

1. Détecte et compile MG2D si nécessaire (ou utilise `mg2d.jar` pré-compilé)
2. Compile les fichiers `.java` du menu principal (racine du projet)
3. Compile chaque jeu Java dans `projet/` avec MG2D dans le classpath
4. Génère les fichiers `.class` nécessaires à l'exécution

### 3.2 Exécution des jeux

Chaque jeu dispose d'un script `.sh` à la racine du projet (ex. `Pong.sh`, `JavaSpace.sh`). Le flux d'exécution est :

1. `lancerBorne.sh` configure le layout clavier XKB et lance le menu Java (`Main.java` → `Graphique.java`)
2. Le menu graphique découvre automatiquement les jeux dans `projet/`
3. Quand l'utilisateur sélectionne un jeu, `game_wrapper.sh` est appelé
4. `game_wrapper.sh` ré-applique le layout clavier `borne` puis exécute le script `.sh` du jeu

## 4. Dépendances

### 4.1 Dépendances système

- **Java JDK** : Pour compiler et exécuter les jeux Java et le menu principal
- **Python 3.8+** : Pour les jeux Python (Pygame) et les scripts de génération de documentation
- **LÖVE (Love2D)** : Pour les jeux Lua (ex. CursedWare)
- **Pygame** : Bibliothèque Python utilisée par plusieurs jeux (ball-blast, OsuTile, PianoTile, TronGame)
- **MG2D** : Bibliothèque graphique Java utilisée par le menu et la majorité des jeux Java
- **Ollama** : Serveur LLM pour la génération automatique de documentation (optionnel)
- **Shell (bash)** : Pour les scripts d'exécution

### 4.2 Dépendances logicielles

- **Clavier arcade** : Layout XKB personnalisé (`borne`) pour le remapping des touches
- **Serveur graphique** : X11 ou Wayland (Raspberry Pi OS avec labwc)

## 5. Structure des dossiers

### 5.1 Dossier `projet/`

Contient les implémentations des jeux, organisées par langage :

```
projet/
├── ball-blast/        (Python/Pygame)
├── Columns/           (Java/MG2D)
├── CursedWare/        (Lua/LÖVE)
├── DinoRail/          (Java/MG2D)
├── Galad-Scott/       (sous-projet externe)
├── InitialDrift/      (Java/MG2D)
├── JavaSpace/         (Java/MG2D)
├── Kowasu_Renga/      (Java/MG2D)
├── Minesweeper/       (Java/MG2D)
├── OsuTile/           (Python/Pygame)
├── PianoTile/         (Python/Pygame)
├── Pong/              (Java/MG2D)
├── Puissance_X/       (Java/MG2D)
├── Snake_Eater/       (Java/MG2D)
└── TronGame/          (Python/Pygame)
```

Chaque jeu contient :
- Ses fichiers sources
- `description.txt` : description affichée dans le menu
- `bouton.txt` : mapping des boutons de la borne
- `DOCUMENTATION.md` : documentation générée par l'IA
- `tests/Tests.java`, `test.py` ou `test.lua` : tests générés par l'IA

### 5.2 Dossier `docs/`

Documentation technique et d'installation :

```
docs/
├── GUIDE_RAPIDE.md
├── installation/
│   ├── overview.md
│   └── generator.md
└── outils/
    └── ollama_wrapper.md
```

## 6. Points d'extension

### 6.1 Ajout de nouveaux jeux

Pour ajouter un nouveau jeu :

1. Créer un dossier dans `projet/` avec le nom du jeu
2. Ajouter les fichiers sources du jeu
3. Ajouter `description.txt`, `bouton.txt` et une image `photo_small.png`
4. Créer un script `NomDuJeu.sh` à la racine du projet
5. Le menu graphique détecte automatiquement le nouveau dossier au prochain lancement

### 6.2 Personnalisation de l'interface

L'interface de sélection est gérée par le code Java (`Graphique.java`, `Bouton.java`, `Pointeur.java`). Elle découvre dynamiquement les jeux présents dans `projet/`. Pour personnaliser :

- Modifier `Graphique.java` pour l'affichage
- Modifier `Bouton.java` pour la représentation des jeux
- Changer les images de fond dans `img/`

### 6.3 Génération de documentation

Le générateur de documentation peut être étendu via :

- Modification de `generate_docs_and_tests.py`
- Ajout de fichiers de configuration dans `config.ini`
- Personnalisation des prompts utilisés pour la génération

## 7. Configuration du clavier arcade

Le projet utilise une configuration spécifique pour le clavier arcade :

### 7.1 Entrées utilisateur

- **Joystick J1** : Flèches directionnelles (haut, bas, gauche, droite)
- **Joystick J2** : Touches spécifiques (O, L, K, M)
- **6 touches J1** : R, T, Y (haut) et F, G, H (bas)
- **6 touches J2** : A, Z, E (haut) et Q, S, D (bas)

### 7.2 Mapping

Le mapping est implémenté dans `ClavierBorneArcade.java` (à la racine du projet), qui traduit les touches du clavier en actions pour les jeux. Le fichier `borne` contient le layout XKB personnalisé qui remape les touches physiques de l'encodeur clavier de la borne.

## 8. Génération automatique de documentation

Le projet utilise Ollama pour générer automatiquement :

- La documentation technique des jeux
- Les tests unitaires pour chaque jeu

Les scripts `generate_docs.sh` et `generate_docs_and_tests.py` permettent de générer ces documents à partir des sources du projet.
