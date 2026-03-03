#!/usr/bin/env python3
"""
Script de test pour vérifier la configuration d'Ollama avant la génération.
"""

import sys
from pathlib import Path

from ollama_wrapper_iut import OllamaWrapper


def test_ollama_connection():
    """Teste la connexion au serveur Ollama."""
    print("=" * 60)
    print("TEST DE CONNEXION OLLAMA")
    print("=" * 60)
    print()
    
    # Initialise le wrapper
    ollama = OllamaWrapper()
    print(f"📡 URL du serveur : {ollama._base_url}")
    print()
    
    # Test 1 : Serveur accessible
    print("1️⃣  Test de connexion au serveur...")
    if ollama.is_server_running():
        print("   ✅ Serveur accessible")
    else:
        print("   ❌ Serveur inaccessible")
        print("   💡 Vérifiez qu'Ollama est démarré")
        return False
    print()
    
    # Test 2 : Version du serveur
    print("2️⃣  Récupération de la version...")
    try:
        version = ollama.get_version()
        print(f"   ✅ Version Ollama : {version}")
    except Exception as e:
        print(f"   ❌ Erreur : {e}")
        return False
    print()
    
    # Test 3 : Liste des modèles
    print("3️⃣  Liste des modèles disponibles...")
    try:
        models = ollama.list_models()
        if models:
            print(f"   ✅ {len(models)} modèle(s) disponible(s) :")
            for model in models:
                size_mb = model.size // (1024*1024) if model.size else 0
                print(f"      • {model.name:30} ({size_mb:,} MB)")
        else:
            print("   ⚠️  Aucun modèle installé")
            print("   💡 Téléchargez un modèle : ollama pull gemma2:latest")
            return False
    except Exception as e:
        print(f"   ❌ Erreur : {e}")
        return False
    print()
    
    # Test 4 : Génération de test
    print("4️⃣  Test de génération de texte...")
    
    # Trouve un modèle disponible
    model_to_test = "gemma2:latest"
    available_models = [m.name for m in models]
    
    if model_to_test not in available_models:
        if "gemma2:2b" in available_models:
            model_to_test = "gemma2:2b"
        elif available_models:
            model_to_test = available_models[0]
        else:
            print("   ⚠️  Aucun modèle pour tester")
            return False
    
    print(f"   📝 Test avec le modèle : {model_to_test}")
    
    try:
        result = ollama.generate_text(
            model=model_to_test,
            prompt="Réponds en un mot : quelle est la capitale de la France ?",
            options={"temperature": 0.1, "num_predict": 20}
        )
        response = result.response.strip()
        print(f"   ✅ Génération OK : '{response}'")
        
        if result.total_duration:
            duration_s = result.total_duration / 1_000_000_000
            print(f"   ⏱️  Durée : {duration_s:.2f}s")
    except Exception as e:
        print(f"   ❌ Erreur de génération : {e}")
        return False
    print()
    
    # Résumé
    print("=" * 60)
    print("✅ TOUS LES TESTS RÉUSSIS")
    print("=" * 60)
    print()
    print("Vous pouvez maintenant lancer :")
    print("  ./generate_docs.sh")
    print("  ou")
    print("  python3 generate_docs_and_tests.py")
    print()
    
    return True


def main():
    """Point d'entrée."""
    success = test_ollama_connection()
    sys.exit(0 if success else 1)


if __name__ == "__main__":
    main()
