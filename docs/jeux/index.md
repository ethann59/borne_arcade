# Vue d'ensemble des jeux

La borne d'arcade contient 14 jeux développés dans différents langages.

## 📊 Liste complète des jeux

| Jeu | Langage | Framework | Statut |
|-----|---------|-----------|--------|
| [ball-blast](ball-blast.md) | Python | Pygame | ✅ |
| [Columns](Columns.md) | Java | MG2D | ✅ |
| [CursedWare](CursedWare.md) | Lua | Love2D | ✅ |
| [DinoRail](DinoRail.md) | Java | MG2D | ✅ |
| [InitialDrift](InitialDrift.md) | Java | MG2D | ✅ |
| [JavaSpace](JavaSpace.md) | Java | MG2D | ✅ |
| [Kowasu_Renga](Kowasu_Renga.md) | Java | MG2D | ✅ |
| [Minesweeper](Minesweeper.md) | Java | MG2D | ✅ |
| [OsuTile](OsuTile.md) | Lua | Love2D | ✅ |
| [PianoTile](PianoTile.md) | Lua | Love2D | ✅ |
| [Pong](Pong.md) | Python | Pygame | ✅ |
| [Puissance_X](Puissance_X.md) | Java | MG2D | ✅ |
| [Snake_Eater](Snake_Eater.md) | Java | MG2D | ✅ |
| [TronGame](TronGame.md) | Python | Pygame | ✅ |

!!! note "Note"
    Galad-Scott est exclu de la génération automatique de documentation car il dispose déjà de sa propre documentation.

## 🎮 Catégories de jeux

### Jeux d'action

- **JavaSpace** : Shoot'em up spatial classique
- **ball-blast** : Destruction de balles en cascade

### Jeux de réflexion

- **Columns** : Puzzle game d'alignement
- **Minesweeper** : Démineur traditionnel
- **Puissance_X** : Puissance 4 avec variantes

### Jeux de rythme

- **OsuTile** : Jeu de rythme inspiré d'Osu!
- **PianoTile** : Piano tiles classique

### Jeux de casse-briques

- **Kowasu_Renga** : Casse-briques amélioré

### Jeux d'arcade classiques

- **Snake_Eater** : Snake avec power-ups
- **Pong** : Tennis de table pixelisé
- **TronGame** : Course de motos Tron

### Jeux de course

- **DinoRail** : Course avec obstacles
- **InitialDrift** : Jeu de drift

### Collections

- **CursedWare** : Collection de mini-jeux (style WarioWare)

## 🚀 Lancer un jeu

Chaque jeu a son script de lancement :

```bash
# Depuis la racine du projet
./JavaSpace.sh
./Pong.sh
./CursedWare.sh
# etc.
```

## 📝 Générer la documentation d'un jeu

Pour générer ou régénérer la documentation complète d'un jeu :

```bash
./generate_docs.sh NomDuJeu
```

Exemple :

```bash
./generate_docs.sh JavaSpace
```

Cela crée :
- `projet/JavaSpace/DOCUMENTATION_AI.md` : Documentation complète
- `projet/JavaSpace/TestsAI.java` : Tests unitaires

## 🔍 Accéder aux documentations

Cliquez sur le nom d'un jeu dans le tableau ci-dessus pour accéder à sa documentation complète.

Chaque documentation inclut :

- ✅ Description et objectif du jeu
- ✅ Règles et gameplay
- ✅ Architecture technique
- ✅ Guide d'installation
- ✅ Contrôles et utilisation
- ✅ Structure du code
- ✅ Suggestions d'amélioration

## 🛠️ Développement

### Ajouter un nouveau jeu

1. Créer le dossier dans `projet/`
2. Ajouter les fichiers sources
3. Créer les fichiers requis :
   - `bouton.txt` : Configuration des boutons
   - `description.txt` : Description courte
   - `highscore` : Fichier des scores
4. Créer le script de lancement `.sh`
5. Générer la documentation : `./generate_docs.sh NouveauJeu`

### Conventions de nommage

- Dossier : `NomDuJeu/` (PascalCase ou snake_case)
- Script : `NomDuJeu.sh` 
- Classe principale : `Main.java` ou `NomDuJeu.java`
- Documentation : `DOCUMENTATION_AI.md`
- Tests : `TestsAI.{java|py|lua}`

## 📊 Statistiques

- **Total** : 14 jeux opérationnels
- **Java** : 9 jeux (64%)
- **Python** : 3 jeux (21%)
- **Lua** : 3 jeux (21%)

## 🎯 High scores

Les scores sont sauvegardés dans le fichier `highscore` de chaque jeu :

```bash
cat projet/JavaSpace/highscore
cat projet/Snake_Eater/highscore
```

## 📚 Ressources

- [Installation des jeux](../installation/overview.md)
- [Guide de maintenance](../maintenance/procedures.md)
- [Retour à l'accueil](../index.md)
