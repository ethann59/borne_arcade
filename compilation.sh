#!/usr/bin/env bash
set -euo pipefail

# compilation.sh — Compilation des sources de la borne et des jeux
# - détecte MG2D (variable d'env MG2D_DIR sinon cherche ~/git/MG2D, /home/pi/git/MG2D, ./MG2D)
# - compile MG2D si nécessaire
# - compile menu et chaque jeu en ajoutant MG2D au classpath

MG2D_REPO="https://github.com/synave/MG2D.git"
MG2D_DIR="${MG2D_DIR:-$HOME/git/MG2D}"

# Try common locations if default doesn't exist
if [ ! -d "$MG2D_DIR" ]; then
  if [ -d "$HOME/git/MG2D" ]; then
    MG2D_DIR="$HOME/git/MG2D"
  elif [ -d "/home/pi/git/MG2D" ]; then
    MG2D_DIR="/home/pi/git/MG2D"
  elif [ -d "./MG2D" ]; then
    MG2D_DIR="$(pwd)/MG2D"
  fi
fi

# Offer to clone if not present
if [ ! -d "$MG2D_DIR" ]; then
  echo "MG2D introuvable. Chemin testé: $MG2D_DIR"
  read -r -p "Voulez-vous cloner MG2D dans ${MG2D_DIR%/*} ? [Y/n] " ans || true
  ans=${ans:-Y}
  if [[ "$ans" =~ ^[Yy]$ ]]; then
    mkdir -p "$(dirname "$MG2D_DIR")"
    git clone "$MG2D_REPO" "${MG2D_DIR}" || { echo "Échec du clonage de MG2D"; exit 1; }
  else
    echo "MG2D requis pour la compilation. Définissez MG2D_DIR ou clonez le dépôt puis relancez." >&2
    exit 1
  fi
fi

# Compute classpath entry: parent directory of MG2D (so that import MG2D.* trouve la racine)
MG2D_CP="$(dirname "$MG2D_DIR")"

# Compile MG2D if there is no .class
if ! find "$MG2D_DIR" -name "*.class" -print -quit >/dev/null 2>&1; then
  echo "Compilation de MG2D..."
  (cd "$MG2D_DIR" && javac MG2D/*.java MG2D/geometrie/*.java MG2D/audio/*.java) || { echo "Échec compilation MG2D"; exit 1; }
  echo "MG2D compilé."
fi

echo "Compilation du menu de la borne d'arcade"
echo "Veuillez patienter"
javac -cp .:"$MG2D_CP" *.java

cd projet

for i in *; do
    if [ -d "$i" ]; then
        cd "$i"
        echo "Compilation du jeu $i"
        echo "Veuillez patienter"
        javac -cp .:"$MG2D_CP" *.java || { echo "Échec de compilation du jeu $i"; cd ..; continue; }
        cd ..
    fi
done

cd ..

echo "Compilation terminée. Si des erreurs persistent, vérifiez que MG2D est bien à jour et compilé."