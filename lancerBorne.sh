#!/bin/bash

setxkbmap borne

# Déterminer le répertoire du script et se déplacer dedans
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR" || exit 1

# Définir les chemins (utilisera SCRIPT_DIR si pas sur le Raspberry Pi)
if [ -d "/home/pi/git/borne_arcade" ]; then
  export BORNE_DIR="/home/pi/git/borne_arcade"
else
  export BORNE_DIR="$SCRIPT_DIR"
fi
GALAD_SCOTT_DIR="$BORNE_DIR/projet/Galad-Scott"

# Lancer le script de mise à jour automatique
echo "╔════════════════════════════════════════════════════╗"
echo "║   Vérification des mises à jour...                ║"
echo "╚════════════════════════════════════════════════════╝"

# Exécuter updater.sh et capturer le code de retour
# Le code de retour est 0 si des mises à jour ont été appliquées, 1 sinon
if ./updater.sh; then
  BORNE_UPDATED=true
  echo ""
  echo "✅ Des mises à jour ont été appliquées"
  
  # Vérifier si des modifications ont été stashées
  if [ -f .stash_reminder ]; then
    echo ""
    echo "╔════════════════════════════════════════════════════╗"
    echo "║   ⚠️  ATTENTION : Modifications locales stashées  ║"
    echo "╚════════════════════════════════════════════════════╝"
    echo ""
    cat .stash_reminder
    echo ""
    echo "Appuyez sur Entrée pour continuer..."
    read -r
  fi
else
  BORNE_UPDATED=false
  echo ""
  echo "ℹ️  Aucune mise à jour nécessaire"
fi

# Activate local virtualenv if present (created by install.sh as .venv)
if [ -f "$BORNE_DIR/.venv/bin/activate" ]; then
  echo "Activation du virtualenv local: $BORNE_DIR/.venv"
  # shellcheck disable=SC1091
  source "$BORNE_DIR/.venv/bin/activate"
fi

echo ""
if [ "$BORNE_UPDATED" = true ]; then
  echo "╔════════════════════════════════════════════════════╗"
  echo "║   Recompilation nécessaire après mise à jour      ║"
  echo "╚════════════════════════════════════════════════════╝"
  echo "Nettoyage des répertoires..."
  ./clean.sh
  echo "Compilation en cours..."
  ./compilation.sh
else
  echo "╔════════════════════════════════════════════════════╗"
  echo "║   Aucune recompilation nécessaire                 ║"
  echo "╚════════════════════════════════════════════════════╝"
fi

# If compilation artifacts are missing, try to detect a prebuilt mg2d.jar first
mg2d_candidates=("$BORNE_DIR/../MG2D/mg2d.jar" "/home/pi/git/MG2D/mg2d.jar" "$HOME/git/MG2D/mg2d.jar" "$BORNE_DIR/MG2D/mg2d.jar")
found_mg2d_jar=""
for c in "${mg2d_candidates[@]}"; do
  [ -f "$c" ] || continue
  found_mg2d_jar="$c"
  break
done

if [ -n "$found_mg2d_jar" ] && [ ! -f .mg2d_env ]; then
  echo "mg2d.jar detecte: $found_mg2d_jar — ecriture de .mg2d_env"
  echo "export MG2D_CP='$found_mg2d_jar'" > .mg2d_env
fi

if [ ! -f Main.class ] || [ ! -f .mg2d_env ]; then
  echo "Fichiers compilés manquants ou .mg2d_env absent — lancement de ./compilation.sh"
  ./compilation.sh
fi

# Source MG2D classpath from compilation (re-source after possible compilation)
if [ -f .mg2d_env ]; then
  # shellcheck disable=SC1091
  source .mg2d_env
else
  MG2D_CP="/home/pi/git/MG2D/mg2d.jar"  # fallback to jar location
fi

echo ""
echo "╔════════════════════════════════════════════════════╗"
echo "║   Lancement du Menu de la Borne Arcade            ║"
echo "╚════════════════════════════════════════════════════╝"
echo "Veuillez patienter..."
echo ""

java -cp .:"$MG2D_CP" Main

echo ""
echo "╔════════════════════════════════════════════════════╗"
echo "║   Nettoyage avant extinction                       ║"
echo "╚════════════════════════════════════════════════════╝"
./clean.sh

echo ""
echo "╔════════════════════════════════════════════════════╗"
echo "║   ⏰ Extinction programmée dans 30 secondes       ║"
echo "╚════════════════════════════════════════════════════╝"

for i in {30..1}
do
    echo -ne "\r⏳ Extinction dans $i secondes... "
    sleep 1
done

echo ""
echo ""
echo "╔════════════════════════════════════════════════════╗"
echo "║   🔌 Extinction de la borne en cours...           ║"
echo "╚════════════════════════════════════════════════════╝"

sudo halt
