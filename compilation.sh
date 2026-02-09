#!/usr/bin/env bash
set -euo pipefail

# compilation.sh — Compilation des sources de la borne et des jeux
# - détecte MG2D (variable d'env MG2D_DIR sinon cherche ~/git/MG2D, /home/pi/git/MG2D, ./MG2D)
# - compile MG2D si nécessaire
# - compile menu et chaque jeu en ajoutant MG2D au classpath

MG2D_REPO="https://github.com/synave/MG2D.git"
MG2D_DIR="${MG2D_DIR:-$HOME/git/MG2D}"

# Normalize path
if command -v realpath >/dev/null 2>&1; then
  MG2D_DIR="$(realpath -m "$MG2D_DIR")"
else
  MG2D_DIR="${MG2D_DIR%/}"
fi

SCRIPT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
candidates=(
  "$SCRIPT_ROOT/MG2D"
  "$SCRIPT_ROOT/projet/MG2D"
  "$MG2D_DIR"
  "$HOME/git/MG2D"
  "/home/pi/git/MG2D"
  "./MG2D"
)

found=""
for c in "${candidates[@]}"; do
  # Check if this directory contains the standard MG2D repo structure (MG2D/MG2D/, Makefile)
  if [ -f "$c/Makefile" ] && [ -d "$c/MG2D" ] && [ -f "$c/MG2D/Fenetre.java" ]; then
    found="$c"
    break
  fi
done

if [ -n "$found" ]; then
  MG2D_DIR="$found"
fi

# Offer to clone if not present
if [ ! -d "$MG2D_DIR" ] || [ ! -f "$MG2D_DIR/Makefile" ] || [ ! -d "$MG2D_DIR/MG2D" ]; then
  echo "MG2D introuvable. Chemin testé: $MG2D_DIR (Makefile et MG2D/ requis)"
  read -r -p "Voulez-vous cloner MG2D dans ${MG2D_DIR} ? [Y/n] " ans || true
  ans=${ans:-Y}
  if [[ "$ans" =~ ^[Yy]$ ]]; then
    mkdir -p "$(dirname "$MG2D_DIR")"
    git clone "$MG2D_REPO" "$MG2D_DIR" || { echo "Échec du clonage de MG2D"; exit 1; }
  else
    echo "MG2D requis pour la compilation. Définissez MG2D_DIR ou clonez le dépôt puis relancez." >&2
    exit 1
  fi
fi

# Use parent of MG2D_DIR as classpath (so that import MG2D.* works correctly)
MG2D_CP="$(dirname "$MG2D_DIR/MG2D")"
echo "MG2D détecté dans: $MG2D_DIR"
echo "Classpath utilisé: $MG2D_CP"

# Compile MG2D if there are no .class files (suivre le Makefile officiel)
if ! find "$MG2D_DIR/MG2D" -name "*.class" -print -quit >/dev/null 2>&1; then
  echo "Compilation de MG2D..."
  (cd "$MG2D_DIR" && javac MG2D/*.java MG2D/geometrie/*.java MG2D/audio/*.java) || { echo "Échec compilation MG2D"; exit 1; }
  echo "MG2D compilé."
fi

# Export MG2D path for other scripts
echo "export MG2D_CP='$MG2D_CP'" > .mg2d_env

echo "Compilation du menu de la borne d'arcade"
echo "Veuillez patienter"
javac -cp .:"$MG2D_CP" *.java

cd projet

for i in *; do
    if [ -d "$i" ]; then
        cd "$i"
        echo "Compilation du jeu $i"
        echo "Veuillez patienter"
        # Ajuster le classpath depuis les sous-dossiers (../..:$MG2D_CP au lieu de .:$MG2D_CP)
        javac -cp .:"$MG2D_CP":../.. *.java || { echo "Échec de compilation du jeu $i"; cd ..; continue; }
        cd ..
    fi
done

cd ..

echo "Compilation terminée. Si des erreurs persistent, vérifiez que MG2D est bien à jour et compilé."