#!/bin/bash

setxkbmap borne

# Déterminer le répertoire du script et se déplacer dedans
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR" || exit 1

# Définir les chemins
export BORNE_DIR="$SCRIPT_DIR"
GALAD_SCOTT_DIR="$BORNE_DIR/projet/Galad-Scott"

set_time_manually_from_http() {
  local http_date=""
  local target_utc=""

  if ! command -v curl >/dev/null 2>&1; then
    echo "curl introuvable — réglage manuel de l'heure impossible."
    return 1
  fi

  http_date="$(curl -fsSI --max-time 8 https://www.google.com 2>/dev/null | grep -i '^date:' | head -n1 | sed -E 's/^[Dd]ate:[[:space:]]*//' | tr -d '\r')"
  if [ -z "$http_date" ]; then
    echo "Date HTTP introuvable — réglage manuel ignoré."
    return 1
  fi

  target_utc="$(LC_ALL=C date -u -d "$http_date" '+%Y-%m-%d %H:%M:%S' 2>/dev/null || true)"
  if [ -z "$target_utc" ]; then
    echo "Impossible de parser la date réseau: $http_date"
    return 1
  fi

  if command -v timedatectl >/dev/null 2>&1; then
    timedatectl set-time "$target_utc" >/dev/null 2>&1 || sudo -n timedatectl set-time "$target_utc" >/dev/null 2>&1 || true
  fi

  if ! date -u -s "$target_utc" >/dev/null 2>&1; then
    sudo -n date -u -s "$target_utc" >/dev/null 2>&1 || true
  fi

  if [ "$(date -u '+%Y-%m-%d %H:%M:%S')" = "$target_utc" ]; then
    echo "Heure réglée manuellement depuis la date réseau (UTC): $target_utc"
    return 0
  fi

  echo "Échec du réglage manuel de l'heure (droits insuffisants ?)."
  return 1
}

sync_system_time_runtime() {
  echo "Synchronisation de l'heure de la borne..."
  local synced=false

  echo "Vérification de la connexion Internet (ping google.com)..."
  if ping -c 1 -W 2 google.com >/dev/null 2>&1; then
    echo "Connexion Internet disponible — synchronisation de l'heure ignorée."
    echo "Heure actuelle: $(date -Is)"
    return 0
  fi

  if command -v timedatectl >/dev/null 2>&1; then
    timedatectl set-ntp true >/dev/null 2>&1 || sudo -n timedatectl set-ntp true >/dev/null 2>&1 || true

    for _ in {1..10}; do
      if [ "$(timedatectl show -p NTPSynchronized --value 2>/dev/null || echo no)" = "yes" ]; then
        echo "Heure synchronisée via NTP."
        echo "Heure actuelle: $(date -Is)"
        synced=true
        return 0
      fi
      sleep 1
    done
  fi

  if command -v ntpdate >/dev/null 2>&1; then
    if ntpdate -u pool.ntp.org >/dev/null 2>&1 || sudo -n ntpdate -u pool.ntp.org >/dev/null 2>&1; then
      synced=true
    fi
  fi

  if [ "$synced" != true ]; then
    echo "Synchronisation NTP non concluante — tentative de réglage manuel de l'heure."
    set_time_manually_from_http || true
  fi

  echo "Heure actuelle: $(date -Is)"
}

sync_system_time_runtime

java_artifacts_missing() {
  # Vérifie les classes Java du menu (racine)
  for src in "$BORNE_DIR"/*.java; do
    [ -f "$src" ] || continue
    cls="${src%.java}.class"
    if [ ! -f "$cls" ] || [ "$src" -nt "$cls" ]; then
      return 0
    fi
  done

  # Vérifie les classes Java des jeux (niveau direct projet/<jeu>/*.java)
  for game_dir in "$BORNE_DIR"/projet/*; do
    [ -d "$game_dir" ] || continue
    for src in "$game_dir"/*.java; do
      [ -f "$src" ] || continue
      cls="${src%.java}.class"
      if [ ! -f "$cls" ] || [ "$src" -nt "$cls" ]; then
        return 0
      fi
    done
  done

  return 1
}

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
  fi
else
  BORNE_UPDATED=false
  echo ""
  echo "ℹ️  Aucune mise à jour nécessaire"
fi

BORNE_REPO_UPDATED=false
GALAD_SCOTT_UPDATED=false
if [ -f .update_state ]; then
  # shellcheck disable=SC1091
  source .update_state
fi

# Activate local virtualenv if present (created by install.sh as .venv)
if [ -f "$BORNE_DIR/.venv/bin/activate" ]; then
  echo "Activation du virtualenv local: $BORNE_DIR/.venv"
  # shellcheck disable=SC1091
  source "$BORNE_DIR/.venv/bin/activate"
fi

echo ""
if [ "$BORNE_REPO_UPDATED" = true ]; then
  echo "╔════════════════════════════════════════════════════╗"
  echo "║   Recompilation complète après MAJ de la borne    ║"
  echo "╚════════════════════════════════════════════════════╝"
  echo "Nettoyage des répertoires..."
  ./clean.sh
  echo "Compilation en cours..."
  ./compilation.sh
elif [ "$GALAD_SCOTT_UPDATED" = true ]; then
  echo "╔════════════════════════════════════════════════════╗"
  echo "║   MAJ Galad-Scott: compilation ciblée             ║"
  echo "╚════════════════════════════════════════════════════╝"
  echo "Nettoyage des répertoires..."
  ./clean.sh
  echo "Compilation menu + Galad-Scott..."
  ONLY_GALAD_SCOTT=true ./compilation.sh
else
  echo "╔════════════════════════════════════════════════════╗"
  echo "║   Aucune MAJ : vérification de la compilation     ║"
  echo "╚════════════════════════════════════════════════════╝"
fi

# MG2D: uniquement .mg2d_env ou MG2D/mg2d.jar
if [ ! -f .mg2d_env ] && [ -f "$BORNE_DIR/MG2D/mg2d.jar" ]; then
  echo "mg2d.jar detecte: $BORNE_DIR/MG2D/mg2d.jar — ecriture de .mg2d_env"
  echo "export MG2D_CP='$BORNE_DIR/MG2D/mg2d.jar'" > .mg2d_env
fi

if [ -f .mg2d_env ]; then
  # shellcheck disable=SC1091
  source .mg2d_env
fi

if java_artifacts_missing || [ -z "${MG2D_CP:-}" ]; then
  echo "Classes Java manquantes/obsolètes ou .mg2d_env absent — lancement de ./compilation.sh"
  if [ "$BORNE_REPO_UPDATED" = true ]; then
    ./compilation.sh
  elif [ "$GALAD_SCOTT_UPDATED" = true ]; then
    ONLY_GALAD_SCOTT=true ./compilation.sh
  else
    ./compilation.sh
  fi
fi

if java_artifacts_missing; then
  echo "[ERREUR] Certaines classes Java sont toujours manquantes ou obsolètes après compilation."
  exit 1
fi

# Source MG2D classpath from compilation (re-source after possible compilation)
if [ -f .mg2d_env ]; then
  # shellcheck disable=SC1091
  source .mg2d_env
elif [ -f "$BORNE_DIR/MG2D/mg2d.jar" ]; then
  MG2D_CP="$BORNE_DIR/MG2D/mg2d.jar"
else
  echo "[ERREUR] MG2D introuvable. Attendu: .mg2d_env ou $BORNE_DIR/MG2D/mg2d.jar"
  exit 1
fi

echo ""
echo "╔════════════════════════════════════════════════════╗"
echo "║   Lancement du Menu de la Borne Arcade            ║"
echo "╚════════════════════════════════════════════════════╝"
echo "Veuillez patienter..."
echo ""

JAVA_RENDER_OPTS="${JAVA_RENDER_OPTS:--Dsun.java2d.opengl=false -Dsun.java2d.xrender=false -Dsun.java2d.pmoffscreen=false}"
java $JAVA_RENDER_OPTS -cp .:"$MG2D_CP" Main

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
