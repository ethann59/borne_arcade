# À propos

## 🎮 Projet Borne d'Arcade

Cette documentation couvre le projet de maintenance de la borne d'arcade.


### 🎯 Objectifs du projet

Ce projet vise à :

1. **Maintenir** une collection de 14 jeux d'arcade
2. **Automatiser** la génération de documentation technique
3. **Standardiser** les tests et la qualité du code
4. **Faciliter** l'ajout de nouveaux jeux
5. **Utiliser** l'IA pour assister le développement

## 🎮 Jeux inclus

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

### Langages de programmation

- **Java** : 9 jeux
  - Framework : MG2D
  - Tests : JUnit 5
  
- **Python 3** : 4 jeux
  - Framework : Pygame
  - Tests : pytest
  
- **Lua** : 3 jeux
  - Framework : Love2D
  - Tests : busted

### Outils de développement

- **Ollama** : Génération automatique de documentation via IA
- **MkDocs** : Documentation technique
- **Git** : Gestion de versions
- **Bash** : Scripts de compilation et lancement

### Modèles IA utilisés

- **gemma2:latest** : Génération de documentation (défaut)
- **gemma2:2b** : Alternative plus rapide
- **mistral:latest** : Alternative créative

## 📁 Structure du projet

```
borne_arcade/
├── projet/               # Tous les jeux
│   ├── ball-blast/
│   ├── JavaSpace/
│   ├── TronGame/
│   └── ...
├── MG2D/                 # Framework Java
├── docs/                 # Documentation MkDocs
├── *.sh                  # Scripts de lancement
├── generate_docs*.py     # Générateur IA
├── ollama_wrapper_iut.py # API Ollama
└── mkdocs.yml           # Configuration doc
```

## 🤖 Innovation : Génération par IA

### Principe

Le projet intègre un système innovant de génération automatique de documentation et de tests utilisant l'IA Ollama :

1. **Analyse** : Le générateur scanne le code source
2. **Contexte** : Extrait les informations pertinentes
3. **IA** : Envoie à Ollama avec un prompt structuré
4. **Génération** : Produit documentation + tests
5. **Sauvegarde** : Écrit les fichiers dans le projet

### Avantages

- ✅ **Gain de temps** : Documentation en quelques minutes
- ✅ **Standardisation** : Format uniforme pour tous les jeux
- ✅ **Qualité** : Tests complets générés automatiquement
- ✅ **Maintenance** : Facilite les mises à jour

### Limites

- ⚠️ Nécessite relecture humaine
- ⚠️ Qualité variable selon le modèle
- ⚠️ Dépend de la connexion au serveur

## 📊 Statistiques

### Par langage

```
Java     : ████████████████░░░░ 64% (9 jeux)
Python   : ████░░░░░░░░░░░░░░░░ 21% (4 jeux)
Lua      : ████░░░░░░░░░░░░░░░░ 21% (3 jeux)
```

## 👥 Équipe

Ce projet est réalisé dans le cadre d'un travail universitaire par Ethann Cailliau.

### Contributeurs

- Développeurs des jeux originaux
- Intégration et maintenance : Ethann Cailliau
- Documentation IA : Système automatisé avec Ollama

## 📜 Licence

Les jeux appartient à leur propriétaire respectifs.

Les jeux et le code sont développés à des fins pédagogiques.

## 🔗 Liens utiles

### Documentation technique

- [Guide rapide](GUIDE_RAPIDE.md)
- [Installation](installation/overview.md)
- [Jeux](jeux/index.md)
- [Outils](outils/ollama_wrapper.md)
- [Maintenance](maintenance/procedures.md)

### Ressources externes

- [Ollama](https://ollama.com/)
- [MkDocs](https://www.mkdocs.org/)
- [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)
- [MG2D](https://github.com/aurelien-naldi/MG2D)
- [Pygame](https://www.pygame.org/)
- [Love2D](https://love2d.org/)

## 📞 Contact

Pour toute question concernant ce projet :

- Consulter d'abord la [section dépannage](maintenance/troubleshooting.md)
- Vérifier les [procédures de maintenance](maintenance/procedures.md)
- Contacter les responsables du module SA

---

**Version de la documentation** : 1.0  
**Dernière mise à jour** : Mars 2026  
**Générée avec** : MkDocs + Material theme
