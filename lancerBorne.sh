#!/bin/bash

# === Keyboard Layout Configuration ===
# Stratégies (par ordre de préférence) :
#   Wayland : layout utilisateur ($HOME/.config/xkb/symbols/) + configuration du compositeur (labwc)
#   X11     : setxkbmap avec racine XKB locale
#   Fallback: avertissement

install_xkb_layout_user() {
  # Installe le fichier XKB borne dans le répertoire utilisateur de libxkbcommon (>= 1.0).
  # Ce chemin est recherché par libxkbcommon avant /usr/share/X11/xkb, sans sudo.
  local src="$1"
  local user_xkb_dir="$HOME/.config/xkb/symbols"
  local dest="$user_xkb_dir/borne"

  mkdir -p "$user_xkb_dir"
  if [ -f "$dest" ] && cmp -s "$src" "$dest" 2>/dev/null; then
    return 0  # Déjà à jour
  fi
  cp "$src" "$dest" 2>/dev/null && echo "Layout XKB 'borne' installé dans $dest" || true
}

configure_labwc_keyboard() {
  # Configure labwc (compositeur Wayland de Raspberry Pi OS / LXQt) pour utiliser
  # le layout borne.  labwc recharge rc.xml sur réception de SIGHUP.
  local layout="$1"
  local variant="$2"
  local labwc_dir="$HOME/.config/labwc"
  local labwc_rc="$labwc_dir/rc.xml"
  local labwc_env="$labwc_dir/environment"
  local changed=false

  mkdir -p "$labwc_dir"

  # --- rc.xml : section <keyboard> ---
  local layout_attr="layout=\"$layout\""
  [ -n "$variant" ] && layout_attr="$layout_attr variant=\"$variant\""

  if [ ! -f "$labwc_rc" ]; then
    cat > "$labwc_rc" <<RCEOF
<?xml version="1.0"?>
<labwc_config>
  <keyboard>
    <default $layout_attr />
  </keyboard>
</labwc_config>
RCEOF
    changed=true
    echo "labwc rc.xml créé : $labwc_rc"
  else
    if grep -q "layout=\\\"$layout\\\"" "$labwc_rc" 2>/dev/null; then
      echo "labwc rc.xml déjà configuré pour layout '$layout'."
    else
      local tmp_rc
      tmp_rc="$(mktemp)"
      if grep -q '<keyboard>' "$labwc_rc" 2>/dev/null; then
        # Remplacer une éventuelle balise <default .../> existante
        sed '/<keyboard>/,/<\/keyboard>/{
          s|<default[^/]*/[[:space:]]*>|<default '"$layout_attr"' />|
        }' "$labwc_rc" > "$tmp_rc"
        # Si aucune balise <default> n'existait, en ajouter une
        if ! grep -q "layout=\\\"$layout\\\"" "$tmp_rc" 2>/dev/null; then
          sed '/<keyboard>/a\    <default '"$layout_attr"' />' "$labwc_rc" > "$tmp_rc"
        fi
      else
        # Pas de section <keyboard> — l'insérer avant </labwc_config>
        sed 's|</labwc_config>|  <keyboard>\n    <default '"$layout_attr"' />\n  </keyboard>\n</labwc_config>|' "$labwc_rc" > "$tmp_rc"
      fi
      if ! cmp -s "$labwc_rc" "$tmp_rc" 2>/dev/null; then
        cp "$tmp_rc" "$labwc_rc"
        changed=true
        echo "labwc rc.xml mis à jour : keyboard layout='$layout'"
      fi
      rm -f "$tmp_rc"
    fi
  fi

  # --- environment : XKB_DEFAULT_* (fallback pour composants Wayland tiers) ---
  local tmp_env
  tmp_env="$(mktemp)"
  if [ -f "$labwc_env" ]; then
    grep -vE '^(XKB_DEFAULT_LAYOUT|XKB_DEFAULT_VARIANT)=' "$labwc_env" > "$tmp_env" 2>/dev/null || true
  fi
  echo "XKB_DEFAULT_LAYOUT=$layout" >> "$tmp_env"
  [ -n "$variant" ] && echo "XKB_DEFAULT_VARIANT=$variant" >> "$tmp_env"

  if ! cmp -s "$labwc_env" "$tmp_env" 2>/dev/null; then
    cp "$tmp_env" "$labwc_env"
    changed=true
    echo "labwc environment mis à jour."
  fi
  rm -f "$tmp_env"

  # Recharger labwc
  if [ "$changed" = true ] && pgrep -x labwc >/dev/null 2>&1; then
    pkill -SIGHUP labwc 2>/dev/null || true
    echo "labwc rechargé (SIGHUP)."
    sleep 0.5
  fi
}

apply_keyboard_layout_runtime() {
  local script_dir
  script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  local target_layout="${TARGET_KEYBOARD_LAYOUT:-borne}"
  local fallback_layout="${FALLBACK_KEYBOARD_LAYOUT:-fr}"
  local effective_layout=""
  local effective_variant=""
  local session_type="${XDG_SESSION_TYPE:-unknown}"
  local setxkbmap_include_opt=()
  local setxkbmap_variant_opt=()

  # --- Étape 1 : préparer les fichiers XKB ---
  local local_xkb_root="$script_dir/.xkb_local"
  if [ "$target_layout" = "borne" ] && [ -f "$script_dir/borne" ]; then
    mkdir -p "$local_xkb_root/symbols"
    cp "$script_dir/borne" "$local_xkb_root/symbols/borne" 2>/dev/null || true
    setxkbmap_include_opt=(-I "$local_xkb_root")
    # Chemin utilisateur libxkbcommon >= 1.0 (Debian Bookworm+), sans sudo
    install_xkb_layout_user "$script_dir/borne"
  fi

  # --- Étape 2 : déterminer le layout effectif ---
  if command -v setxkbmap >/dev/null 2>&1; then
    if [ "$target_layout" = "borne" ]; then
      if setxkbmap "${setxkbmap_include_opt[@]}" -layout "$target_layout" -variant basic -print >/dev/null 2>&1; then
        effective_layout="$target_layout"
        effective_variant="basic"
      else
        effective_layout="$fallback_layout"
        echo "[WARN] Layout '$target_layout(basic)' introuvable, fallback vers '$effective_layout'."
      fi
    elif setxkbmap "${setxkbmap_include_opt[@]}" -layout "$target_layout" -print >/dev/null 2>&1; then
      effective_layout="$target_layout"
    else
      effective_layout="$fallback_layout"
      echo "[WARN] Layout '$target_layout' introuvable, fallback vers '$effective_layout'."
    fi
  else
    effective_layout="$target_layout"
    [ "$target_layout" = "borne" ] && effective_variant="basic"
  fi

  if [ -n "$effective_variant" ]; then
    setxkbmap_variant_opt=(-variant "$effective_variant")
    echo "Configuration clavier: layout '$effective_layout' variant '$effective_variant' (session: $session_type)"
  else
    echo "Configuration clavier: layout '$effective_layout' (session: $session_type)"
  fi

  # --- Étape 3 : appliquer le layout ---
  if [ "$session_type" = "wayland" ]; then
    # === Chemin Wayland ===
    # Configurer le compositeur (labwc sur RPi OS) pour que TOUS les clients
    # (Wayland natifs + XWayland / Java AWT) reçoivent le bon keymap.
    if pgrep -x labwc >/dev/null 2>&1; then
      configure_labwc_keyboard "$effective_layout" "$effective_variant"
    fi

    # Variables XKB_DEFAULT_* pour les clients Wayland lancés après ce point
    export XKB_DEFAULT_LAYOUT="$effective_layout"
    [ -n "$effective_variant" ] && export XKB_DEFAULT_VARIANT="$effective_variant"

    # Tentative setxkbmap pour XWayland (complémentaire, peut être sans effet)
    if command -v setxkbmap >/dev/null 2>&1 && [ -n "${DISPLAY:-}" ]; then
      setxkbmap "${setxkbmap_include_opt[@]}" -layout "$effective_layout" "${setxkbmap_variant_opt[@]}" >/dev/null 2>&1 || true
    fi

    echo "Layout Wayland configuré."
    return 0
  fi

  # === Chemin X11 ===
  # Exporter XKB_DEFAULT_* pour que SDL2/libxkbcommon (Pygame) puisse résoudre
  # le layout « borne » indépendamment de ce que le serveur X rapporte en RMLVO.
  export XKB_DEFAULT_LAYOUT="$effective_layout"
  [ -n "$effective_variant" ] && export XKB_DEFAULT_VARIANT="$effective_variant"

  if command -v setxkbmap >/dev/null 2>&1 && [ -n "${DISPLAY:-}" ]; then
    if setxkbmap "${setxkbmap_include_opt[@]}" -layout "$effective_layout" "${setxkbmap_variant_opt[@]}" >/dev/null 2>&1; then
      echo "Layout appliqué via setxkbmap."
      return 0
    fi
  fi

  echo "[WARN] Remapping clavier non appliqué automatiquement."
  return 0
}

apply_keyboard_layout_runtime

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

JAVA_RENDER_OPTS="${JAVA_RENDER_OPTS:--Dsun.java2d.opengl=true -Dsun.java2d.xrender=true -Dsun.java2d.pmoffscreen=false}"
# _JAVA_AWT_WM_NONREPARENTING=1 évite les problèmes de fenêtre sous tiling WMs / Wayland.
# Java AWT utilise toujours X11 (via XWayland sous Wayland) — le layout est géré
# au niveau du compositeur (labwc) ou de setxkbmap (X11).
_JAVA_AWT_WM_NONREPARENTING=1 java $JAVA_RENDER_OPTS -cp .:"$MG2D_CP" Main

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
