# Borne d'Arcade — IUT du Littoral Côte d'Opale

Logiciel de borne d'arcade pédagogique développé à l'IUT du Littoral Côte d'Opale (IUTLCO). Le projet propose un menu de sélection de jeux et une collection de **14 jeux** développés en Java, Python et Lua.

> Projet initié en 2017-2018 par Romaric Bougard, Pierre Delobel et Bastien Ducloy.
> Repris et maintenu depuis par les promotions successives.

## Prérequis

| Dépendance | Version recommandée |
|------------|---------------------|
| Java (JDK) | OpenJDK 17+ |
| Python     | 3.x + Pygame |
| Love2D     | 11.x (pour CursedWare) |

**Matériel cible** : Raspberry Pi 3+, écran 4:3 (1280×1024), 2 joysticks + 6 boutons par joueur.

## Installation rapide

```bash
git clone <url_du_dépôt> borne_arcade
cd borne_arcade
chmod +x *.sh
./install.sh          # installe les dépendances (Debian/Ubuntu/RPi OS)
./compilation.sh      # compile le menu et les jeux Java
```

Le script `install.sh` supporte les options `--interactive`, `--non-interactive` et `--dry-run`.

## Lancement

```bash
./lancerBorne.sh      # applique le layout clavier, compile si nécessaire, lance le menu
```

Au démarrage, le script :
1. Installe et active le layout clavier XKB personnalisé `borne`
2. Recompile les sources si nécessaire
3. Lance le menu Java de sélection de jeux
4. Éteint la machine à la fermeture du menu

Pour lancer un jeu isolé : `./NomDuJeu.sh` (ex. `./Pong.sh`).

## Mapping clavier

La borne utilise un layout XKB personnalisé (fichier `borne`). Les encodeurs de chaque joueur sont mappés ainsi :

|               | Joystick        | X   | Y   | Z   | A   | B   | C   |
|---------------|-----------------|-----|-----|-----|-----|-----|-----|
| **Joueur 1**  | Flèches ↑↓←→   | R   | T   | Y   | F   | G   | H   |
| **Joueur 2**  | O / L / K / M   | A   | Z   | E   | Q   | S   | D   |

Chaque jeu précise ses contrôles dans le fichier `bouton.txt` du répertoire `projet/<jeu>/`.

## Jeux disponibles

| Jeu | Langage | Framework | Catégorie |
|-----|---------|-----------|-----------|
| ball-blast | Python | Pygame | Action |
| Columns | Java | MG2D | Réflexion |
| CursedWare | Lua | Love2D | Mini-jeux |
| DinoRail | Java | MG2D | Course |
| InitialDrift | Java | MG2D | Course |
| JavaSpace | Java | MG2D | Shoot'em up |
| Kowasu_Renga | Java | MG2D | Casse-briques |
| Minesweeper | Java | MG2D | Réflexion |
| OsuTile | Python | Pygame | Rythme |
| PianoTile | Python | Pygame | Rythme |
| Pong | Java | MG2D | Arcade |
| Puissance_X | Java | MG2D | Réflexion |
| Snake_Eater | Java | MG2D | Arcade |
| TronGame | Python | Pygame | Arcade |

Galad-Scott (Python) dispose de sa [documentation dédiée](https://ethann59.github.io/Galad-Scott/).

## Structure du projet

```
├── Main.java / *.java       # Menu principal (Java + MG2D)
├── projet/                   # Code source de chaque jeu
│   ├── <jeu>/
│   │   ├── bouton.txt        # Mapping des contrôles
│   │   ├── description.txt   # Description affichée dans le menu
│   │   └── tests/            # Tests unitaires (JUnit 5 / pytest / busted)
├── docs/                     # Documentation MkDocs (Material)
├── MG2D/                     # Bibliothèque graphique Java
├── borne                     # Layout clavier XKB personnalisé
├── lancerBorne.sh            # Script de lancement principal
├── compilation.sh            # Compilation du menu et des jeux Java
├── install.sh                # Installation automatisée des dépendances
├── run_tests.sh              # Exécution des tests (Java, Python, Lua)
└── generate_docs_and_tests.py  # Génération IA de docs/tests via Ollama
```

## Documentation

La documentation complète est générée avec MkDocs Material :

```bash
pip install mkdocs mkdocs-material pymdown-extensions
mkdocs serve        # serveur local sur http://127.0.0.1:8000
mkdocs build        # génération statique dans site/
```

## Tests

```bash
./run_tests.sh      # lance tous les tests (Java, Python, Lua)
```

Le script détecte automatiquement les fichiers de test dans `projet/*/tests/` (Java) et `projet/*/test.py` / `test.lua`, télécharge JUnit 5 si nécessaire, et affiche un résumé OK/FAIL/SKIP.

## Outils IA

Le script `generate_docs_and_tests.py` génère automatiquement documentation et tests unitaires pour chaque jeu via un serveur [Ollama](https://ollama.ai/) :

```bash
cp config.ini.example config.ini   # configurer l'URL du serveur Ollama
python3 generate_docs_and_tests.py
```

## Licence

Projet pédagogique de l'IUT du Littoral Côte d'Opale.
Par Ethann Cailliau