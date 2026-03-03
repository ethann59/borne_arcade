# Guide rapide

Ce guide permet de lancer rapidement la génération de documentation et de tests avec Ollama.

## 1) Vérifier Ollama

```bash
./test_ollama.py
```

Si le test échoue, vérifiez que le serveur répond sur `http://10.22.28.190:11434`.

## 2) Générer la doc d’un jeu (recommandé)

```bash
./generate_docs.sh JavaSpace
```

Fichiers générés (exemple) :
- `projet/JavaSpace/DOCUMENTATION_AI.md`
- `projet/JavaSpace/TestsAI.java`

## 3) Générer pour tous les jeux

```bash
./generate_docs.sh
```

!!! warning "Durée"
    Le traitement complet peut prendre 10 à 30 minutes selon le modèle et la charge serveur.

## 4) Consulter les résultats

Dans chaque dossier de jeu, vous trouverez :
- `DOCUMENTATION_AI.md` (documentation)
- `TestsAI.java` (Java)
- `test_ai.py` (Python)
- `test_ai.lua` (Lua)

## Commandes utiles

Utiliser un autre modèle :

```bash
python3 generate_docs_and_tests.py --model mistral:latest
```

Mode silencieux :

```bash
python3 generate_docs_and_tests.py --quiet
```

Aide complète :

```bash
python3 generate_docs_and_tests.py --help
```

## Dépannage rapide

Serveur non accessible :

```bash
curl http://10.22.28.190:11434/api/version
```

Modèle absent :

```bash
ollama pull gemma2:latest
```

Timeout :

```bash
python3 generate_docs_and_tests.py --model gemma2:2b
```

## Workflow conseillé

1. `./test_ollama.py`
2. `./generate_docs.sh JavaSpace`
3. Vérifier `projet/JavaSpace/DOCUMENTATION_AI.md`
4. `./generate_docs.sh` (global)

## Intégration MkDocs

Ce fichier est dans `docs/GUIDE_RAPIDE.md` et est directement utilisé par `mkdocs.yml` via l’entrée `Guide Rapide`.
