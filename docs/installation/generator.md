# Installation du générateur de documentation

Le générateur utilise Ollama pour créer automatiquement la documentation et les tests des jeux.

## 📋 Prérequis

### 1. Python 3.8+

Vérifiez que Python est installé :

```bash
python3 --version
```

### 2. Serveur Ollama

Le générateur nécessite un accès à un serveur Ollama.

#### Option A : Serveur centralisé (IUT)

Par défaut, le générateur utilise le serveur IUT :

```
http://10.22.28.190:11434
```

Testez la connexion :

```bash
curl http://10.22.28.190:11434/api/version
```

#### Option B : Installation locale

Si vous souhaitez installer Ollama localement :

```bash
# Télécharger Ollama
curl -fsSL https://ollama.com/install.sh | sh

# Démarrer le serveur
ollama serve &

# Télécharger un modèle
ollama pull gemma2:latest
```

## 🔧 Configuration

### 1. Vérifier les fichiers

Assurez-vous que ces fichiers sont présents :

```bash
ls -la generate_docs_and_tests.py
ls -la generate_docs.sh  
ls -la test_ollama.py
ls -la ollama_wrapper_iut.py
```

### 2. Rendre les scripts exécutables

```bash
chmod +x generate_docs_and_tests.py
chmod +x generate_docs.sh
chmod +x test_ollama.py
```

### 3. Configuration optionnelle

Pour personnaliser les paramètres, créez un fichier de configuration :

```bash
cp config.ini.example config.ini
nano config.ini
```

Modifiez les valeurs selon vos besoins :

```ini
[ollama]
base_url = http://10.22.28.190:11434
default_model = gemma2:latest
timeout = 120

[generation]
doc_temperature = 0.7
test_temperature = 0.5
max_files_per_game = 20
```

## ✅ Test de l'installation

### 1. Tester la connexion Ollama

```bash
./test_ollama.py
```

Vous devriez voir :

```
============================================================
TEST DE CONNEXION OLLAMA
============================================================

📡 URL du serveur : http://10.22.28.190:11434

1️⃣  Test de connexion au serveur...
   ✅ Serveur accessible

2️⃣  Récupération de la version...
   ✅ Version Ollama : 0.1.x

3️⃣  Liste des modèles disponibles...
   ✅ 2 modèle(s) disponible(s) :
      • gemma2:latest                (5,000 MB)
      • gemma2:2b                    (2,000 MB)

4️⃣  Test de génération de texte...
   📝 Test avec le modèle : gemma2:latest
   ✅ Génération OK : 'Paris'
   ⏱️  Durée : 2.34s

============================================================
✅ TOUS LES TESTS RÉUSSIS
============================================================
```

### 2. Générer la documentation d'un jeu test

```bash
./generate_docs.sh JavaSpace
```

### 3. Vérifier le résultat

```bash
ls -la projet/JavaSpace/DOCUMENTATION_AI.md
ls -la projet/JavaSpace/TestsAI.java
```

Si ces fichiers existent, l'installation est réussie ! ✅

## 🐛 Dépannage

### Erreur : "Serveur Ollama inaccessible"

1. Vérifiez que le serveur est démarré
2. Testez la connexion réseau :
   ```bash
   ping 10.22.28.190
   curl http://10.22.28.190:11434/api/version
   ```
3. Vérifiez le firewall

### Erreur : "Modèle non trouvé"

Téléchargez le modèle :

```bash
ollama pull gemma2:latest
```

Ou utilisez un modèle plus léger :

```bash
ollama pull gemma2:2b
```

### Erreur de permission

```bash
chmod +x *.sh *.py
```

## 📚 Ressources

- [Guide rapide](../GUIDE_RAPIDE.md)
- [Documentation du wrapper Ollama](../outils/ollama_wrapper.md)
- [Retour à l'installation](overview.md)
