#!/bin/bash
# game_wrapper.sh — Lanceur intermédiaire utilisé par Pointeur.java.
# Ré-applique le layout clavier XKB « borne » puis exécute le script de jeu.
#
# Usage : ./game_wrapper.sh <nom_du_jeu>
#   Exemple : ./game_wrapper.sh ball-blast   →  exécute ./ball-blast.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GAME_NAME="${1:?Usage: $0 <nom_du_jeu>}"
GAME_SCRIPT="$SCRIPT_DIR/${GAME_NAME}.sh"

if [ ! -f "$GAME_SCRIPT" ]; then
  echo "[ERREUR] Script de jeu introuvable : $GAME_SCRIPT" >&2
  exit 1
fi

# ── Ré-appliquer le layout clavier borne ──────────────────────────────────────
# Sous X11/XWayland, setxkbmap modifie le keymap du serveur X.
# Sous Wayland natif, les variables XKB_DEFAULT_* sont utilisées par SDL2/libxkbcommon.

XKB_LOCAL="$SCRIPT_DIR/.xkb_local"

if [ -f "$SCRIPT_DIR/borne" ]; then
  mkdir -p "$XKB_LOCAL/symbols"
  cp "$SCRIPT_DIR/borne" "$XKB_LOCAL/symbols/borne" 2>/dev/null || true

  # Installer dans le chemin utilisateur libxkbcommon >= 1.0 (sans sudo)
  USER_XKB_DIR="$HOME/.config/xkb/symbols"
  mkdir -p "$USER_XKB_DIR"
  cp "$SCRIPT_DIR/borne" "$USER_XKB_DIR/borne" 2>/dev/null || true
fi

# setxkbmap (X11 / XWayland)
if command -v setxkbmap >/dev/null 2>&1 && [ -n "${DISPLAY:-}" ]; then
  setxkbmap -I "$XKB_LOCAL" -layout borne -variant basic 2>/dev/null || true
fi

# Variables d'environnement pour SDL2/libxkbcommon (Wayland natif)
export XKB_DEFAULT_LAYOUT=borne
export XKB_DEFAULT_VARIANT=basic

# ── Lancer le jeu ─────────────────────────────────────────────────────────────
cd "$SCRIPT_DIR"
exec bash "$GAME_SCRIPT"
