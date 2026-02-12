#!/bin/bash

setxkbmap borne

BORNE_DIR="/home/pi/git/borne_arcade"
GALAD_SCOTT_DIR="$BORNE_DIR/projet/Galad-Scott"
BORNE_UPDATED=false

check_updates() {
  local name="$1"
  local dir="$2"
  local updated_flag_var="$3"

  if [ ! -d "$dir/.git" ]; then
    echo "Aucune source git pour $name (dossier: $dir)"
    return 0
  fi

  if ! command -v git >/dev/null 2>&1; then
    echo "git introuvable, mise a jour ignoree pour $name"
    return 0
  fi

  local upstream
  upstream=$(git -C "$dir" rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null || true)
  if [ -z "$upstream" ]; then
    echo "Aucun upstream configure pour $name"
    return 0
  fi

  git -C "$dir" fetch --quiet

  local local_rev remote_rev base_rev
  local_rev=$(git -C "$dir" rev-parse HEAD)
  remote_rev=$(git -C "$dir" rev-parse "$upstream")
  base_rev=$(git -C "$dir" merge-base HEAD "$upstream")

  if [ "$local_rev" = "$remote_rev" ]; then
    echo "$name est a jour"
    return 0
  fi

  if [ "$local_rev" = "$base_rev" ]; then
    echo "Mise a jour disponible pour $name"
    if ! read -r -n 1 -t 8 -p "Appuyez sur la touche 'u' pour mettre a jour (8s), autre touche pour ignorer: " answer; then
      echo
      echo "Aucune touche detectee, mise a jour ignoree pour $name"
      return 0
    fi
    echo
    if [ "$answer" = "u" ] || [ "$answer" = "U" ]; then
      git -C "$dir" pull --rebase
      if [ -n "$updated_flag_var" ]; then
        eval "$updated_flag_var=true"
      fi
    else
      echo "Mise a jour ignoree pour $name"
    fi
    return 0
  fi

  if [ "$remote_rev" = "$base_rev" ]; then
    echo "$name est en avance sur l'upstream (aucune mise a jour)"
    return 0
  fi

  echo "$name a diverge de l'upstream (mise a jour ignoree)"
}

check_updates "borne_arcade" "$BORNE_DIR" BORNE_UPDATED
check_updates "Galad-Scott" "$GALAD_SCOTT_DIR" ""

cd "$BORNE_DIR"

# Activate local virtualenv if present (created by install.sh as .venv)
if [ -f "$BORNE_DIR/.venv/bin/activate" ]; then
  echo "Activation du virtualenv local: $BORNE_DIR/.venv"
  # shellcheck disable=SC1091
  source "$BORNE_DIR/.venv/bin/activate"
fi

if [ "$BORNE_UPDATED" = true ]; then
  echo "nettoyage des répertoires"
  echo "Veuillez patienter"
  ./clean.sh
  ./compilation.sh
else
  echo "Aucune mise a jour de la borne, compilation ignoree"
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

echo "Lancement du  Menu"
echo "Veuillez patienter"

java -cp .:"$MG2D_CP" Main

./clean.sh

for i in {30..1}
do
    echo Extinction de la borne dans $i secondes
    sleep 1
done

sudo halt
