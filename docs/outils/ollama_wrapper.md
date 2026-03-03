# Wrapper Ollama

Le wrapper Ollama est une bibliothèque Python qui facilite l'interaction avec l'API HTTP d'Ollama. Il est fourni par l'IUT de Calais pour permettre aux étudiants de générer automatiquement la documentation et les tests des jeux de la borne d'arcade.

## 📋 Vue d'ensemble

Le fichier `ollama_wrapper_iut.py` fournit une interface Python robuste et typée pour :

- ✅ Vérifier la connexion au serveur Ollama
- ✅ Lister les modèles disponibles
- ✅ Générer du texte avec des prompts
- ✅ Générer du texte avec des images (multimodal)
- ✅ Créer des embeddings

## 🔧 Architecture

### Classes principales

#### `OllamaWrapper`

Classe principale qui gère toutes les interactions avec Ollama.
Changez l'adresse du serveur dans le constructeur si nécessaire.

```python
from ollama_wrapper_iut import OllamaWrapper

# Initialisation
client = OllamaWrapper(
    base_url="http://10.22.28.190:11434",
    timeout_s=120.0
)
```

#### Dataclasses de réponse

- `OllamaModelInfo` : Informations sur un modèle
- `OllamaModelDetails` : Détails techniques d'un modèle
- `OllamaGenerateResult` : Résultat de génération de texte

### Exceptions

```python
OllamaError              # Erreur générique
OllamaConnectionError    # Erreur de connexion
OllamaResponseError      # Erreur de réponse
OllamaServerStartError   # Erreur de démarrage serveur
```

## 📚 Utilisation

### Vérifier la connexion

```python
from ollama_wrapper_iut import OllamaWrapper

client = OllamaWrapper()

if client.is_server_running():
    print("✅ Serveur accessible")
    version = client.get_version()
    print(f"Version : {version}")
else:
    print("❌ Serveur inaccessible")
```

### Lister les modèles

```python
models = client.list_models()

for model in models:
    size_mb = model.size // (1024*1024) if model.size else 0
    print(f"• {model.name:30} ({size_mb:,} MB)")
```

Exemple de sortie :

```
• gemma2:latest                (5,100 MB)
• gemma2:2b                    (1,600 MB)
• mistral:latest               (4,100 MB)
```

### Générer du texte

```python
result = client.generate_text(
    model="gemma2:latest",
    prompt="Explique ce qu'est un jeu d'arcade en une phrase.",
    system="Tu es un expert en jeux vidéo.",
    options={
        "temperature": 0.7,
        "num_predict": 100
    }
)

print(result.response)
print(f"Tokens générés : {result.eval_count}")
print(f"Durée : {result.total_duration / 1_000_000_000:.2f}s")
```

### Générer avec une image (multimodal)

```python
from pathlib import Path

result = client.generate_with_image(
    model="llava:latest",
    prompt="Décris cette image en détail.",
    image=Path("screenshot.png"),
    options={"temperature": 0.5}
)

print(result.response)
```

### Créer des embeddings

```python
embedding = client.embed(
    model="gemma2:latest",
    text="Documentation technique de la borne d'arcade"
)

print(f"Vecteur de {len(embedding)} dimensions")
print(f"Premiers éléments : {embedding[:5]}")
```

## ⚙️ Configuration

### URL du serveur

Par défaut : `http://10.22.28.190:11434`

Pour modifier, éditer le fichier `ollama_wrapper_iut.py` :

```python
class OllamaWrapper:
    def __init__(
        self,
        base_url: str = "http://10.22.28.190:11434",  # ← Modifier ici
        timeout_s: float = 120.0,
    ) -> None:
```

### Timeout

Par défaut : 120 secondes

```python
client = OllamaWrapper(timeout_s=300.0)  # 5 minutes
```

### Options de génération

Options courantes à passer dans le paramètre `options` :

| Option | Type | Description | Défaut |
|--------|------|-------------|--------|
| `temperature` | float | Créativité (0.0-2.0) | 0.8 |
| `num_predict` | int | Nombre max de tokens | 128 |
| `top_p` | float | Nucleus sampling | 0.9 |
| `top_k` | int | Top-k sampling | 40 |
| `seed` | int | Graine aléatoire | - |

Exemple :

```python
options = {
    "temperature": 0.3,     # Plus déterministe
    "num_predict": 500,     # Plus de tokens
    "top_p": 0.95,
    "seed": 42              # Reproductible
}

result = client.generate_text(
    model="gemma2:latest",
    prompt="...",
    options=options
)
```

## 🎯 Endpoints utilisés

Le wrapper utilise les endpoints HTTP suivants :

| Endpoint | Méthode | Description |
|----------|---------|-------------|
| `/api/version` | GET | Version du serveur |
| `/api/tags` | GET | Liste des modèles |
| `/api/generate` | POST | Génération de texte |
| `/api/embed` | POST | Création d'embeddings |

## 🧪 Tests

Tester le wrapper :

```bash
python3 ollama_wrapper_iut.py
```

Sortie attendue :

```python
Server running? True
Version: 0.1.x
Models: ['gemma2:latest', 'gemma2:2b']
Generate : {'définition': 'L'intelligence artificielle...'}
```

## 🐛 Gestion d'erreurs

### Connexion échouée

```python
try:
    client = OllamaWrapper()
    result = client.generate_text(
        model="gemma2:latest",
        prompt="Test"
    )
except OllamaConnectionError as e:
    print(f"❌ Impossible de se connecter : {e}")
except OllamaResponseError as e:
    print(f"❌ Erreur de réponse : {e}")
except OllamaError as e:
    print(f"❌ Erreur Ollama : {e}")
```

## 📖 API complète

### Méthodes système

```python
is_server_running() -> bool
get_version() -> str
list_models() -> List[OllamaModelInfo]
start_server(...) -> subprocess.Popen
```

### Méthodes de génération

```python
generate_text(
    model: str,
    prompt: str,
    system: Optional[str] = None,
    options: Optional[Mapping[str, Any]] = None
) -> OllamaGenerateResult

generate_with_image(
    model: str,
    prompt: str,
    image: Union[str, Path, bytes],
    image_mime_hint: Optional[str] = None,
    system: Optional[str] = None,
    options: Optional[Mapping[str, Any]] = None
) -> OllamaGenerateResult

embed(
    model: str,
    text: str
) -> List[float]
```

## 📚 Ressources

- [Documentation Ollama officielle](https://ollama.com/docs)
- [Guide du générateur](generator.md)
- [Installation](../installation/generator.md)

## 🔍 Exemple complet

```python
#!/usr/bin/env python3
from ollama_wrapper_iut import OllamaWrapper, OllamaError

def main():
    # Initialisation
    client = OllamaWrapper()
    
    # Vérification
    if not client.is_server_running():
        print("❌ Serveur Ollama non accessible")
        return
    
    print(f"✅ Connecté - Version : {client.get_version()}")
    
    # Liste des modèles
    models = client.list_models()
    print(f"📦 {len(models)} modèle(s) disponible(s)")
    
    # Génération
    try:
        result = client.generate_text(
            model="gemma2:latest",
            prompt="Explique les jeux d'arcade en 2 phrases.",
            options={"temperature": 0.7, "num_predict": 100}
        )
        
        print(f"\n📝 Réponse :\n{result.response}")
        
        if result.total_duration:
            duration = result.total_duration / 1_000_000_000
            print(f"\n⏱️ Durée : {duration:.2f}s")
            
    except OllamaError as e:
        print(f"❌ Erreur : {e}")

if __name__ == "__main__":
    main()
```

---

**Fichier source** : [`ollama_wrapper_iut.py`](../../ollama_wrapper_iut.py)
