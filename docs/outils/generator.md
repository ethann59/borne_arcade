# Génération de documentation et tests avec Ollama

Le générateur utilise Ollama pour créer automatiquement la documentation et les tests unitaires des jeux de la borne.

## 📋 Prérequis

### 1. Python 3.8+

```bash
python3 --version
```

### 2. Serveur Ollama

#### Option A : Serveur centralisé (IUT)

Par défaut, le générateur utilise le serveur de l'IUT, accessible uniquement sur le réseau de l'IUT :

```
http://10.22.28.190:11434
```

Testez la connexion :

```bash
curl http://10.22.28.190:11434/api/version
```

#### Option B : Installation locale

```bash
# Télécharger Ollama
curl -fsSL https://ollama.com/install.sh | sh

# Démarrer le serveur
ollama serve &

# Télécharger un modèle
ollama pull qwen3:latest
```

## 🔧 Configuration

### 1. Vérifier les fichiers

```bash
ls -la generate_docs_and_tests.py generate_docs.sh test_ollama.py ollama_wrapper_iut.py
```

### 2. Rendre les scripts exécutables

```bash
chmod +x generate_docs_and_tests.py generate_docs.sh test_ollama.py
```

### 3. Configuration optionnelle

Pour personnaliser les paramètres :

```bash
cp config.ini.example config.ini
nano config.ini
```

```ini
[ollama]
base_url = http://10.22.28.190:11434
default_model = qwen3:latest
timeout = 120

[generation]
doc_temperature = 0.7
test_temperature = 0.5
max_files_per_game = 20
```

## 🚀 Utilisation

### 1. Tester la connexion Ollama

```bash
./test_ollama.py
```

Si le test échoue, vérifiez que le serveur est accessible (voir la configuration dans `ollama_wrapper_iut.py`).

### 2. Générer la doc d'un jeu

```bash
./generate_docs.sh JavaSpace
```

### 3. Générer pour tous les jeux

```bash
./generate_docs.sh
```

!!! warning "Durée"
    Le traitement complet peut prendre 10 à 30 minutes selon le modèle et la charge serveur.

### 4. Consulter les résultats

Dans chaque dossier de jeu, vous trouverez :

- `DOCUMENTATION.md` — documentation technique
- `tests/Tests.java` — tests JUnit 5 (jeux Java)
- `test.py` — tests pytest (jeux Python)
- `test.lua` — tests busted (jeux Lua)

## ⚙️ Commandes utiles

Utiliser un autre modèle :

```bash
python3 generate_docs_and_tests.py --model qwen3:latest
```

Mode silencieux :

```bash
python3 generate_docs_and_tests.py --quiet
```

Aide complète :

```bash
python3 generate_docs_and_tests.py --help
```

## ✅ Workflow conseillé

1. `./test_ollama.py`
2. `./generate_docs.sh JavaSpace`
3. Vérifier `projet/JavaSpace/DOCUMENTATION.md`
4. `./generate_docs.sh` (global)

## 🐛 Dépannage

### Serveur Ollama inaccessible

1. Vérifiez que le serveur est démarré
2. Testez la connexion réseau :
   ```bash
   ping 10.22.28.190
   curl http://10.22.28.190:11434/api/version
   ```
3. Vérifiez le firewall

### Modèle non trouvé

```bash
ollama pull qwen3:latest
```

Ou un modèle plus léger :

```bash
ollama pull qwen2.5:latest
```

### Erreur de permission

```bash
chmod +x *.sh *.py
```

### Timeout

Essayez un modèle plus léger :

```bash
python3 generate_docs_and_tests.py --model qwen2.5:latest
```

## 📚 Ressources

- [Documentation du wrapper Ollama](outils/ollama_wrapper.md)
- [Guide d'installation](INSTALLATION.md)
- [Retour à l'accueil](index.md)
