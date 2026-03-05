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
# Optionnel: compiler uniquement Galad-Scott (et le menu), sans compiler les autres jeux.
ONLY_GALAD_SCOTT="${ONLY_GALAD_SCOTT:-false}"
# Optionnel: encodage source Java (utile sur certaines Debian en locale non UTF-8)
JAVAC_ENCODING="${JAVAC_ENCODING:-UTF-8}"

SCRIPT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Si un fichier .mg2d_env existe (écrit par lancerBorne.sh), l'utiliser prioritairement
# afin de respecter un mg2d.jar fourni (chemins absolus possibles, p.ex. /home/pi/...).
if [ -f "$SCRIPT_ROOT/.mg2d_env" ]; then
  # shellcheck disable=SC1091
  source "$SCRIPT_ROOT/.mg2d_env"
  if [ -n "${MG2D_CP:-}" ]; then
    # si MG2D_CP pointe vers un jar existant, définir MG2D_DIR sur son dossier
    if [ -f "$MG2D_CP" ]; then
      MG2D_DIR="$(dirname "$MG2D_CP")"
    fi
  fi
fi

candidates=(
  "$SCRIPT_ROOT/MG2D"
  "$SCRIPT_ROOT/projet/MG2D"
  "$MG2D_DIR"
  "$HOME/git/MG2D"
  "/home/pi/git/MG2D"
  "./MG2D"
  "$SCRIPT_ROOT"
)

found=""
for c in "${candidates[@]}"; do
  # Check if this directory contains the standard MG2D repo structure (MG2D/MG2D/, Makefile)
  if [ -f "$c/Makefile" ] && [ -d "$c/MG2D" ] && [ -f "$c/MG2D/Fenetre.java" ]; then
    found="$c"
    break
  fi
done

# If no source-tree found, accept a provided mg2d.jar located next to the project
# e.g. ./MG2D/mg2d.jar or ./mg2d.jar — treat that as a valid MG2D installation.
if [ -z "$found" ]; then
  for c in "${candidates[@]}"; do
    if [ -f "$c/mg2d.jar" ]; then
      found="$c"
      break
    fi
    if [ -f "$c" ] && [ "$(basename "$c")" = "mg2d.jar" ]; then
      # candidate points directly to a jar path
      found="$(dirname "$c")"
      break
    fi
  done
fi

if [ -n "$found" ]; then
  MG2D_DIR="$found"
fi

has_mg2d_sources=false
if [ -f "$MG2D_DIR/Makefile" ] && [ -d "$MG2D_DIR/MG2D" ] && [ -f "$MG2D_DIR/MG2D/Fenetre.java" ]; then
  has_mg2d_sources=true
fi

# If neither a source tree nor a prebuilt jar exists, offer to clone (interactive fallback)
mg2d_jar_candidate="$MG2D_DIR/mg2d.jar"
if [ ! -f "$mg2d_jar_candidate" ] && ( [ ! -d "$MG2D_DIR" ] || [ ! -f "$MG2D_DIR/Makefile" ] || [ ! -d "$MG2D_DIR/MG2D" ] ); then
  echo "MG2D introuvable (cherche source ou mg2d.jar). Chemin testé: $MG2D_DIR"
  read -r -p "Voulez-vous cloner MG2D dans ${MG2D_DIR} ? [Y/n] " ans || true
  ans=${ans:-Y}
  if [[ "$ans" =~ ^[Yy]$ ]]; then
    mkdir -p "$(dirname "$MG2D_DIR")"
    git clone "$MG2D_REPO" "$MG2D_DIR" || { echo "Échec du clonage de MG2D"; exit 1; }
  else
    echo "MG2D requis pour la compilation. Définissez MG2D_DIR, placez un mg2d.jar ou clonez le dépôt puis relancez." >&2
    exit 1
  fi
fi

# Prefer a prebuilt JAR if present; otherwise use directory classpath.
mg2d_jar="$MG2D_DIR/mg2d.jar"
if [ -f "$mg2d_jar" ] && [ "$FORCE_REBUILD" != "true" ]; then
  MG2D_CP="$mg2d_jar"
else
  MG2D_CP="$(dirname "$MG2D_DIR/MG2D")"
fi

echo "MG2D détecté dans: $MG2D_DIR"
echo "Classpath utilisé: $MG2D_CP"

# Compilation incrémentale de MG2D: compiler si FORCE_REBUILD=true, si des .class manquent
# ou si un .java est plus récent que son .class correspondant. Après compilation,
# empaqueter MG2D en mg2d.jar pour les déploiements (la borne pourra alors juste
# vérifier la présence de ce .jar au démarrage).
echo "Vérification de l'état de compilation de MG2D..."
need_mg2d_compile=false
mg2d_compile_list=()
if [ "$has_mg2d_sources" = true ]; then
  if [ -f "$mg2d_jar" ] && [ "$FORCE_REBUILD" != "true" ]; then
    echo "mg2d.jar présent — compilation MG2D ignorée (utilisation du JAR)."
  else
    for src in "$MG2D_DIR"/MG2D/*.java "$MG2D_DIR"/MG2D/geometrie/*.java "$MG2D_DIR"/MG2D/audio/*.java; do
      [ -f "$src" ] || continue
      cls="${src%.java}.class"
      if [ "$FORCE_REBUILD" = "true" ] || [ ! -f "$cls" ] || [ "$src" -nt "$cls" ]; then
        need_mg2d_compile=true
        mg2d_compile_list+=("$src")
      fi
    done
  fi
else
  if [ -f "$mg2d_jar" ]; then
    echo "Mode JAR MG2D détecté — vérification des sources MG2D ignorée."
  else
    echo "Sources MG2D absentes et mg2d.jar introuvable — compilation MG2D impossible."
    exit 1
  fi
fi

if [ "$need_mg2d_compile" = true ]; then
  echo "Compilation de MG2D..."
  (cd "$MG2D_DIR" && javac -encoding "$JAVAC_ENCODING" "${mg2d_compile_list[@]}") || { echo "Échec compilation MG2D"; exit 1; }
  echo "MG2D compilé."
  # Créer/mettre à jour le JAR de déploiement
  echo "Génération de $mg2d_jar"
  (cd "$MG2D_DIR" && jar cf "$(basename "$mg2d_jar")" MG2D) || { echo "Échec creation du jar MG2D"; exit 1; }
  MG2D_CP="$mg2d_jar"
else
  echo "MG2D à jour, compilation ignorée."
fi

# Export MG2D path for d'autres scripts
echo "export MG2D_CP='$MG2D_CP'" > .mg2d_env

# Compilation incrémentale du menu principal
echo "Compilation du menu de la borne d'arcade"
echo "Veuillez patienter"
menu_java_files=()
while IFS= read -r -d '' src; do
  menu_java_files+=("${src#./}")
done < <(find . -maxdepth 1 -type f -name '*.java' -print0)

menu_compile_list=()
for src in "${menu_java_files[@]}"; do
  cls="${src%.java}.class"
  if [ "$FORCE_REBUILD" = "true" ] || [ ! -f "$cls" ] || [ "$src" -nt "$cls" ]; then
    menu_compile_list+=("$src")
  fi
done
if [ ${#menu_java_files[@]} -eq 0 ]; then
  echo "Aucun fichier Java de menu trouvé, compilation ignorée."
elif [ ${#menu_compile_list[@]} -eq 0 ]; then
  echo "Vérification explicite Java du menu: tout est à jour."
  echo "Menu à jour, compilation ignorée."
else
  echo "Vérification explicite Java du menu: ${#menu_compile_list[@]} fichier(s) à compiler."
  javac -encoding "$JAVAC_ENCODING" -cp .:"$MG2D_CP" "${menu_compile_list[@]}"
fi

cd projet

for i in *; do
    if [ -d "$i" ]; then
        if [ "$ONLY_GALAD_SCOTT" = "true" ] && [ "$i" != "Galad-Scott" ]; then
          echo "Compilation du jeu $i ignorée (mode Galad-Scott uniquement)."
          continue
        fi
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

        # Vérification explicite et compilation Java incrémentale (récursive, hors tests)
    game_java_files=()
    while IFS= read -r -d '' src; do
      game_java_files+=("${src#./}")
    done < <(find . -type f -name '*.java' ! -path './tests/*' ! -path './*/tests/*' -print0)

    if [ ${#game_java_files[@]} -gt 0 ]; then
      compile_list=()
      for src in "${game_java_files[@]}"; do
        cls="${src%.java}.class"
        if [ "$FORCE_REBUILD" = "true" ] || [ ! -f "$cls" ] || [ "$src" -nt "$cls" ]; then
          compile_list+=("$src")
        fi
      done

      if [ ${#compile_list[@]} -eq 0 ]; then
        echo "Vérification explicite Java pour $i: tout est à jour."
        echo "Jeu $i à jour, compilation ignorée."
      else
        echo "Vérification explicite Java pour $i: ${#compile_list[@]} fichier(s) à compiler."
        javac -encoding "$JAVAC_ENCODING" -cp .:"$MG2D_CP":../.. "${compile_list[@]}" || { echo "Échec de compilation du jeu $i"; cd ..; continue; }
      fi
    else
      echo "Aucun fichier Java pour $i, compilation ignorée."
    fi

        cd ..
    fi
done

cd ..

echo "Compilation terminée. Si des erreurs persistent, vérifiez que MG2D est bien à jour et compilé."