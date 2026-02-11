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

# Optionnel: forcer une recompilation complète (true/false). Utile pour débogage ou CI.
FORCE_REBUILD="${FORCE_REBUILD:-false}"

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

# Compilation incrémentale de MG2D: compiler si FORCE_REBUILD=true, si des .class manquent
# ou si un .java est plus récent que son .class correspondant.
echo "Vérification de l'état de compilation de MG2D..."
need_mg2d_compile=false
mg2d_compile_list=()
for src in "$MG2D_DIR"/MG2D/*.java "$MG2D_DIR"/MG2D/geometrie/*.java "$MG2D_DIR"/MG2D/audio/*.java; do
  [ -f "$src" ] || continue
  cls="${src%.java}.class"
  if [ "$FORCE_REBUILD" = "true" ] || [ ! -f "$cls" ] || [ "$src" -nt "$cls" ]; then
    need_mg2d_compile=true
    mg2d_compile_list+=("$src")
  fi
done

if [ "$need_mg2d_compile" = true ]; then
  echo "Compilation de MG2D..."
  (cd "$MG2D_DIR" && javac "${mg2d_compile_list[@]}") || { echo "Échec compilation MG2D"; exit 1; }
  echo "MG2D compilé."
else
  echo "MG2D à jour, compilation ignorée."
fi

# Export MG2D path for d'autres scripts
echo "export MG2D_CP='$MG2D_CP'" > .mg2d_env

# Compilation incrémentale du menu principal
echo "Compilation du menu de la borne d'arcade"
echo "Veuillez patienter"
menu_compile_list=()
for src in *.java; do
  [ -f "$src" ] || continue
  cls="${src%.java}.class"
  if [ "$FORCE_REBUILD" = "true" ] || [ ! -f "$cls" ] || [ "$src" -nt "$cls" ]; then
    menu_compile_list+=("$src")
  fi
done
if [ ${#menu_compile_list[@]} -eq 0 ]; then
  echo "Menu à jour, compilation ignorée."
else
  javac -cp .:"$MG2D_CP" "${menu_compile_list[@]}"
fi

cd projet

for i in *; do
    if [ -d "$i" ]; then
        cd "$i"
        echo "Compilation du jeu $i"
        echo "Veuillez patienter"

    # Installer les dépendances Python uniquement si besoin (fichier de tampon .requirements_installed)
    if [ -f requirements.txt ]; then
      if command -v python3 >/dev/null 2>&1; then
        if [ ! -f .requirements_installed ] || [ requirements.txt -nt .requirements_installed ]; then
          echo "Installation / mise à jour des dépendances Python pour $i"
          PIP_BREAK_SYSTEM_PACKAGES=1 python3 -m pip install --user -r requirements.txt && touch .requirements_installed
        else
          echo "Dépendances Python pour $i déjà installées, saut."
        fi
      else
        echo "Python3 introuvable, dependances Python ignorees pour $i"
      fi
    fi

        # Compilation Java incrémentale dans le dossier du jeu
    if ls *.java >/dev/null 2>&1; then
      compile_list=()
      for src in *.java; do
        [ -f "$src" ] || continue
        cls="${src%.java}.class"
        if [ "$FORCE_REBUILD" = "true" ] || [ ! -f "$cls" ] || [ "$src" -nt "$cls" ]; then
          compile_list+=("$src")
        fi
      done

      if [ ${#compile_list[@]} -eq 0 ]; then
        echo "Jeu $i à jour, compilation ignorée."
      else
        javac -cp .:"$MG2D_CP":../.. "${compile_list[@]}" || { echo "Échec de compilation du jeu $i"; cd ..; continue; }
      fi
    else
      echo "Aucun fichier Java pour $i, compilation ignorée."
    fi

        cd ..
    fi
done

cd ..

echo "Compilation terminée. Si des erreurs persistent, vérifiez que MG2D est bien à jour et compilé."