# Documentation Borne d'Arcade

Bienvenue dans la documentation technique de la borne d'arcade.

## 🎮 Présentation

Cette borne d'arcade regroupe une collection de 14 jeux développés en différents langages (Java, Python, Lua). Le projet inclut également des outils de génération automatique de documentation et de tests utilisant l'intelligence artificielle via Ollama.

## 📋 Contenu de la documentation

### Pour démarrer rapidement

- **[Guide Rapide](GUIDE_RAPIDE.md)** : Démarrage en 5 minutes
- **[Installation](installation/overview.md)** : Configuration complète du projet

### Documentation des jeux

Chaque jeu dispose de sa propre documentation incluant :

- Description et règles du jeu
- Architecture technique
- Guide d'installation
- Contrôles et utilisation
- Tests unitaires

Consultez la section [Jeux](jeux/index.md) pour accéder aux documentations individuelles.

La documentation dédiée de Galad-Scott est disponible ici : [https://ethann59.github.io/Galad-Scott/](https://ethann59.github.io/Galad-Scott/).

### Outils de développement

- **[Wrapper Ollama](outils/ollama_wrapper.md)** : API Python pour interagir avec Ollama
- **[Générateur de documentation](outils/generator.md)** : Outil automatique de génération de docs et tests
- **[Guide des tests](outils/tests.md)** : Comment exécuter et créer des tests

### Maintenance

- **[Procédures de maintenance](maintenance/procedures.md)** : Guide de maintenance régulière
- **[Dépannage](maintenance/troubleshooting.md)** : Solutions aux problèmes courants

## 🚀 Démarrage rapide

### 1. Tester la connexion Ollama

```bash
./test_ollama.py
```

### 2. Générer la documentation d'un jeu

```bash
./generate_docs.sh JavaSpace
```

### 3. Consulter le résultat

```bash
cat projet/JavaSpace/DOCUMENTATION_AI.md
```

## 📊 Vue d'ensemble des jeux

| Jeu | Langage | Description |
|-----|---------|-------------|
| ball-blast | Python | Jeu de destruction de balles |
| Columns | Java | Puzzle game type Tetris |
| CursedWare | Lua | Collection de mini-jeux WarioWare-like |
| DinoRail | Java | Jeu de course avec obstacles |
| InitialDrift | Java | Jeu de drift automobile |
| JavaSpace | Java | Shoot'em up spatial |
| Kowasu_Renga | Java | Casse-briques |
| Minesweeper | Java | Démineur classique |
| OsuTile | Lua | Jeu de rythme |
| PianoTile | Lua | Jeu de piano tiles |
| Pong | Python | Pong classique |
| Puissance_X | Java | Puissance 4 avec variantes |
| Snake_Eater | Java | Snake amélioré |
| TronGame | Python | Jeu inspiré de Tron |
| Galad Scott | Python | Shoot'em up dans l'univers de Galad Islands |

## 🛠️ Technologies utilisées

- **Langages** : Java, Python 3, Lua
- **Frameworks jeux** : MG2D (Java), Pygame (Python), Love2D (Lua)
- **IA** : Ollama (génération de documentation)
- **Documentation** : MkDocs avec Material theme

## 📞 Support

Pour toute question ou problème :

1. Consultez la section [Dépannage](maintenance/troubleshooting.md)
2. Vérifiez les logs d'exécution
3. Contactez l'équipe de maintenance

---
