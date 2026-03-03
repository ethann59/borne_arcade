#!/bin/bash
# Script de génération de documentation et tests pour les jeux de la borne

cd "$(dirname "$0")"

echo "=========================================="
echo "Générateur de Documentation et Tests IA"
echo "=========================================="
echo ""

# Vérifie que Python est installé
if ! command -v python3 &> /dev/null; then
    echo "ERREUR: Python 3 n'est pas installé"
    exit 1
fi

# Vérifie que le serveur Ollama est accessible
echo "Vérification du serveur Ollama..."
if ! curl -s http://10.22.28.190:11434/api/version > /dev/null 2>&1; then
    echo "ATTENTION: Le serveur Ollama ne semble pas accessible"
    echo "Assurez-vous qu'Ollama est démarré sur http://10.22.28.190:11434"
    echo ""
fi

# Lance le programme
if [ $# -eq 0 ]; then
    echo "Traitement de tous les jeux..."
    echo ""
    python3 generate_docs_and_tests.py
else
    echo "Traitement du jeu: $1"
    echo ""
    python3 generate_docs_and_tests.py --game "$1"
fi

echo ""
echo "Terminé!"
