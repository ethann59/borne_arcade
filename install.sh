#!/usr/bin/env bash
set -euo pipefail

# install.sh — Script d'installation pour Debian/Ubuntu/Raspbian/Fedora/Arch
# Il installe Git et un JDK (la version "par défaut" du dépôt), clone MG2D et borne_arcade
# et place `borne.desktop` dans ~/.config/autostart/.

GIT_DIR="${GIT_DIR:-$HOME/git}"
MG2D_REPO="${MG2D_REPO:-https://github.com/synave/MG2D.git}"
BORNE_REPO="${BORNE_REPO:-https://github.com/ethann59/borne_arcade.git}"
AUTOSTART_DEST="$HOME/.config/autostart/borne.desktop"
DRY_RUN=false
NONINTERACTIVE=false

print_help() {
  cat <<EOF
Usage: $0 [--dry-run] [--non-interactive] [--git-dir PATH]
Options:
  --dry-run           Affiche les actions sans les exécuter
  --non-interactive   Ne demande pas de confirmation (utilisez avec précaution)
  --git-dir PATH      Change le répertoire de destination des clones (défaut: ~/git)

Environment variables (optional):
  PYTHON_PKG          Nom du paquet Python à installer (défaut: python3). Ex: PYTHON_PKG=python3.12
  PYTHON_EXTRAS       Paquets Python supplémentaires (défaut: "python3-venv python3-pip")
  JAVA_PKG            Forcer un paquet JDK spécifique (ex: openjdk-8-jdk)
  LOVE_PKG            Forcer un paquet LÖVE spécifique (ex: love, love2d). Si défini, remplace le paquet par défaut.

  -h, --help          Affiche cette aide
EOF
}

# parse args
while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run) DRY_RUN=true; shift ;;
    --non-interactive) NONINTERACTIVE=true; shift ;;
    --git-dir) GIT_DIR="$2"; shift 2 ;;
    --git-dir=*) GIT_DIR="${1#*=}"; shift ;;
    -h|--help) print_help; exit 0 ;;
    *) echo "Unknown option: $1"; print_help; exit 2 ;;
  esac
done

run_cmd() {
  if [ "$DRY_RUN" = true ]; then
    echo "DRY-RUN: $*"
  else
    echo "+ $*"
    eval "$@"
  fi
}

# require sudo for system installs
if [ "$EUID" -ne 0 ]; then
  echo "Note: certaines opérations nécessitent des privilèges sudo."
  sudo -v || { echo "Erreur: sudo requis."; exit 1; }
fi

# Detect package manager and set packages
PM=""
JAVA_PKG=""
# Python package selection (modifiable via env var): default python3 and common helpers
PYTHON_PKG="${PYTHON_PKG:-python3}"
PYTHON_EXTRAS="${PYTHON_EXTRAS:-python3-venv python3-pip}"
# LÖVE package (modifiable via env var): default 'love' but can be overridden with LOVE_PKG
LOVE_PKG="${LOVE_PKG:-love}"

if command -v apt-get >/dev/null 2>&1; then
  PM=apt
  JAVA_PKG="default-jdk"   # installe la dernière JDK disponible dans la distribution
  INSTALL_CMD="sudo apt-get update && sudo apt-get install -y"
  PKGS=(git "$JAVA_PKG" "$PYTHON_PKG" "$LOVE_PKG" $PYTHON_EXTRAS)
elif command -v dnf >/dev/null 2>&1; then
  PM=dnf
  JAVA_PKG="java-latest-openjdk-devel"
  # Fedora fournit python3 et pip via python3-pip
  PYTHON_EXTRAS="python3-virtualenv python3-pip"
  INSTALL_CMD="sudo dnf install -y"
  PKGS=(git "$JAVA_PKG" "$PYTHON_PKG" "$LOVE_PKG" $PYTHON_EXTRAS)
elif command -v pacman >/dev/null 2>&1; then
  PM=pacman
  JAVA_PKG="jdk-openjdk"
  # Arch: package names differ (python, python-pip)
  PYTHON_PKG="${PYTHON_PKG:-python}"
  PYTHON_EXTRAS="python-pip"
  INSTALL_CMD="sudo pacman -Syu --noconfirm"
  PKGS=(git "$JAVA_PKG" "$PYTHON_PKG" "$LOVE_PKG" $PYTHON_EXTRAS)
else
  echo "Gestionnaire de paquets non pris en charge. Installez manuellement Git, Python et un JDK."
  exit 1
fi

echo "Système détecté: $PM. Paquets à installer: ${PKGS[*]}"

# Install packages
if [ "$NONINTERACTIVE" = false ]; then
  read -r -p "Continuer et installer ces paquets ? [Y/n] " ans || true
  ans=${ans:-Y}
else
  ans=Y
fi

if [[ "$ans" =~ ^[Yy]$ ]]; then
  case "$PM" in
    apt)
      run_cmd sudo apt-get update
      run_cmd sudo apt-get install -y "${PKGS[@]}"
      ;;
    dnf)
      run_cmd sudo dnf install -y "${PKGS[@]}"
      ;;
    pacman)
      run_cmd sudo pacman -Syu --noconfirm "${PKGS[@]}"
      ;;
  esac
else
  echo "Annulé par l'utilisateur."
  exit 0
fi

# Create git dir
run_cmd mkdir -p "$GIT_DIR"

# Clone or update repositories
clone_or_update() {
  local url="$1" name="$2"
  local dest="$GIT_DIR/$name"
  if [ -d "$dest/.git" ]; then
    echo "Mise à jour de $name dans $dest"
    run_cmd git -C "$dest" pull --rebase
  else
    echo "Clonage de $name dans $dest"
    run_cmd git clone "$url" "$dest"
  fi
}

clone_or_update "$MG2D_REPO" "MG2D"
clone_or_update "$BORNE_REPO" "borne_arcade"

# Rendre les scripts exécutables (sécurisé contre l'expansion du shell)
if [ -d "$GIT_DIR/borne_arcade" ]; then
  # Utilise bash -lc pour que le motif '*.sh' soit évalué par la commande find elle-même
  # et on utilise '-exec ... +' pour regrouper les appels chmod, plus efficace.
  run_cmd bash -lc "find \"${GIT_DIR}/borne_arcade\" -maxdepth 2 -type f -name '*.sh' -exec chmod +x {} +"
else
  echo "Aucun dossier $GIT_DIR/borne_arcade trouvé — saut de l'étape chmod."
fi

# Installer borne.desktop dans autostart
if [ -f "$GIT_DIR/borne_arcade/borne.desktop" ]; then
  run_cmd mkdir -p "$(dirname "$AUTOSTART_DEST")"
  if [ -f "$AUTOSTART_DEST" ]; then
    backup="$AUTOSTART_DEST.bak.$(date +%s)"
    echo "Sauvegarde de l'ancien autostart: $backup"
    run_cmd cp -v "$AUTOSTART_DEST" "$backup"
  fi
  echo "Copie de borne.desktop vers $AUTOSTART_DEST"
  run_cmd cp -v "$GIT_DIR/borne_arcade/borne.desktop" "$AUTOSTART_DEST"
else
  echo "Aucun fichier borne.desktop trouvé dans $GIT_DIR/borne_arcade — saut de l'étape autostart."
fi

# Vérifications finales
echo "\n=== Vérification ==="
if command -v java >/dev/null 2>&1; then
  echo "java: $(java -version 2>&1 | head -n 1)"
else
  echo "java: non installé ou non trouvé dans le PATH"
fi
if command -v git >/dev/null 2>&1; then
  echo "git: $(git --version)"
fi

if command -v python3 >/dev/null 2>&1; then
  echo "python3: $(python3 --version)"
else
  echo "python: non installé ou python3 non trouvé dans le PATH"
fi
if command -v pip3 >/dev/null 2>&1; then
  echo "pip3: $(pip3 --version | head -n 1)"
fi

if command -v love >/dev/null 2>&1; then
  echo "love: $(love --version 2>&1 | head -n 1)"
else
  echo "love: non installé ou 'love' non trouvé dans le PATH"
fi

cat <<EOF
✅ Installation terminée.
- Repos clonés dans: $GIT_DIR
- Si vous avez installé le script d'autostart: $AUTOSTART_DEST

Pour lancer le script d'installation : 
  chmod +x install.sh && sudo ./install.sh

Si vous voulez forcer une JDK précise (par exemple openjdk-8-jdk), exportez JAVA_PKG avant d'exécuter:
  export JAVA_PKG=openjdk-8-jdk && sudo ./install.sh

Si vous voulez forcer une version/paquet Python (par exemple python3.12), exportez PYTHON_PKG avant d'exécuter:
  export PYTHON_PKG=python3.12 && sudo ./install.sh

EOF
