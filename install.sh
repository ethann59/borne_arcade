#!/usr/bin/env bash
set -euo pipefail

# install.sh — Script d'installation pour Debian/Ubuntu/Raspbian
# Il installe Git, Python3, un JDK et LÖVE, clone `borne_arcade` et place `borne.desktop`
# dans ~/.config/autostart/. MG2D n'est plus cloné ici — le build utilise
# le `mg2d.jar` fourni dans le dépôt.

GIT_DIR="${GIT_DIR:-$HOME/git}"
BORNE_REPO="${BORNE_REPO:-https://github.com/ethann59/borne_arcade.git}"
GALAD_SCOTT_REPO="${GALAD_SCOTT_REPO:-https://github.com/ethann59/Galad-Scott.git}"
AUTOSTART_DEST="$HOME/.config/autostart/borne.desktop"
DRY_RUN=false
# Exécution sans intervention humaine par défaut
NONINTERACTIVE=true

print_help() {
  cat <<EOF
Usage: $0 [--dry-run] [--interactive] [--non-interactive] [--git-dir PATH]
Options:
  --dry-run           Affiche les actions sans les exécuter
  --interactive       Force les invites (par défaut: non-interactif)
  --non-interactive   Ne demande pas de confirmation (défaut)
  --git-dir PATH      Change le répertoire de destination des clones (défaut: ~/git)

Variables d'environnement (optionnelles):
  PYTHON_PKG          Paquet Python à installer (défaut: python3, ex: PYTHON_PKG=python3.12)
  PYTHON_EXTRAS       Paquets Python supplémentaires (défaut: "python3-venv python3-pip")
  JAVA_PKG            Paquet JDK spécifique (défaut: openjdk-25-jdk)
  LOVE_PKG            Paquet LÖVE (défaut: love)
  GALAD_SCOTT_REPO    URL du dépôt Galad Scott
  GALAD_SCOTT_DEST    Répertoire de destination pour Galad Scott
  INSTALL_PY_REQUIREMENTS  Installer les dépendances Python (true/false, défaut: false)
  PY_PIP_USER_INSTALL      Installer avec --user (défaut: false)
  -h, --help          Affiche cette aide
EOF
}

# parse args
while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run) DRY_RUN=true; shift ;;
    --interactive) NONINTERACTIVE=false; shift ;;
    --non-interactive) NONINTERACTIVE=true; shift ;;
    --git-dir) GIT_DIR="$2"; shift 2 ;;
    --git-dir=*) GIT_DIR="${1#*=}"; shift ;;
    -h|--help) print_help; exit 0 ;;
    *) echo "Unknown option: $1"; print_help; exit 2 ;;
  esac
done

if [ -z "${GALAD_SCOTT_DEST:-}" ]; then
  GALAD_SCOTT_DEST="$GIT_DIR/borne_arcade/projet/Galad-Scott"
fi

run_cmd() {
  if [ "$DRY_RUN" = true ]; then
    echo "DRY-RUN: $*"
  else
    echo "+ $*"
    eval "$@"
  fi
}

# Vérifier que le système est Debian/Ubuntu
if ! command -v apt-get >/dev/null 2>&1; then
  echo "Erreur: apt-get non trouvé. Ce script est prévu pour Debian/Ubuntu."
  exit 1
fi

# Vérifier les privilèges sudo
if [ "$EUID" -ne 0 ]; then
  echo "Vérification des privilèges sudo..."
  sudo -v || { echo "Erreur: sudo requis."; exit 1; }
fi

# Initialiser les variables de paquets
JAVA_PKG="${JAVA_PKG:-openjdk-25-jdk}"
PYTHON_PKG="${PYTHON_PKG:-python3}"
PYTHON_EXTRAS="${PYTHON_EXTRAS:-python3-venv python3-pip}"
LOVE_PKG="${LOVE_PKG:-love}"

PKGS=(git "$JAVA_PKG" "$PYTHON_PKG" "$LOVE_PKG" $PYTHON_EXTRAS)
echo "Système: Debian/Ubuntu"
echo "Paquets à installer: ${PKGS[*]}"

# Install packages
if [ "$NONINTERACTIVE" = false ]; then
  read -r -p "Continuer et installer ces paquets ? [Y/n] " ans || true
  ans=${ans:-Y}
else
  ans=Y
fi

if [[ "$ans" =~ ^[Yy]$ ]]; then
  run_cmd sudo apt-get update
  run_cmd sudo apt-get install -y "${PKGS[@]}"
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

clone_or_update_to() {
  local url="$1" dest="$2"
  if [ -d "$dest/.git" ]; then
    echo "Mise à jour de $(basename "$dest") dans $dest"
    run_cmd git -C "$dest" pull --rebase
  else
    echo "Clonage de $(basename "$dest") dans $dest"
    run_cmd git clone "$url" "$dest"
  fi
}

# MG2D n'est **pas** cloné par ce script — le projet fournit un `mg2d.jar`.
# Si vous avez besoin des sources pour recompiler MG2D, définissez la variable
# d'environnement `MG2D_DIR` ou clonez manuellement le dépôt dans ~/git/MG2D.

clone_or_update "$BORNE_REPO" "borne_arcade"

if [ -d "$GIT_DIR/borne_arcade" ]; then
  run_cmd mkdir -p "$(dirname "$GALAD_SCOTT_DEST")"
  clone_or_update_to "$GALAD_SCOTT_REPO" "$GALAD_SCOTT_DEST"
else
  echo "Dossier borne_arcade introuvable — clone de Galad Scott ignoré."
fi

# === Installation optionnelle des dépendances Python ===
# Contrôlable via la variable d'environnement INSTALL_PY_REQUIREMENTS (true/false)
INSTALL_PY_REQUIREMENTS="${INSTALL_PY_REQUIREMENTS:-false}"
PY_PIP_USER_INSTALL="${PY_PIP_USER_INSTALL:-false}"

# Rassemble tous les fichiers requirements.txt présents (racine du dépôt + projets)
REQ_FILES=()
if [ -f "${GIT_DIR}/borne_arcade/requirements.txt" ]; then
  REQ_FILES+=("${GIT_DIR}/borne_arcade/requirements.txt")
fi
for f in "${GIT_DIR}/borne_arcade"/projet/*/requirements.txt; do
  [ -f "$f" ] && REQ_FILES+=("$f")
done

if [ ${#REQ_FILES[@]} -gt 0 ]; then
  echo "Fichiers de dépendances Python détectés :"
  for r in "${REQ_FILES[@]}"; do echo "  - $r"; done

  if [ "$INSTALL_PY_REQUIREMENTS" != "true" ] && [ "$NONINTERACTIVE" = false ]; then
    read -r -p "Installer ces dépendances ? [y/N] " ans || true
    ans=${ans:-N}
    if [[ "$ans" =~ ^[Yy]$ ]]; then
      INSTALL_PY_REQUIREMENTS=true
    fi
  fi

  if [ "$INSTALL_PY_REQUIREMENTS" = "true" ]; then
    if ! command -v python3 >/dev/null 2>&1; then
      echo "python3 introuvable — impossible d'installer les dépendances Python." 
      return 0
    fi

    # Si l'utilisateur a choisi explicitement 'pip', on installe via pip.
    # Si 'auto' et gestionnaire apt, on essaiera apt d'abord puis basculera sur pip pour
    # les paquets non trouvés. Si 'apt' explicit, on tentera apt et n'utilisera pas pip.
    use_apt=false
    if [ "$INSTALL_PY_METHOD" = "apt" ] || { [ "$INSTALL_PY_METHOD" = "auto" ] && [ "$PM" = "apt" ]; }; then
      use_apt=true
    fi

    # Assurer la présence de pip si on va l'utiliser (fallback ou méthode pip)
    if [ "$use_apt" = false ] || [ "$INSTALL_PY_METHOD" = "pip" ] || [ "$PM" != "apt" ]; then
      if ! python3 -m pip --version >/dev/null 2>&1; then
        echo "pip introuvable pour python3 — tentative d'installation via gestionnaire de paquets..."
        case "$PM" in
          apt) run_cmd sudo apt-get install -y python3-pip ;; 
          dnf) run_cmd sudo dnf install -y python3-pip ;; 
          pacman) run_cmd sudo pacman -S --noconfirm python-pip ;;
        esac
      fi
    fi

    if [ "$use_apt" = true ]; then
      echo "Tentative d'installation des dépendances via apt (fallback vers pip pour les paquets introuvables)."
      for req in "${REQ_FILES[@]}"; do
        echo "Traitement: $req"
        tmpfile=$(mktemp)
        apt_missing=()

        while IFS= read -r line || [ -n "$line" ]; do
          # ignorer commentaires et lignes vides
          line="$(echo "$line" | sed -E 's/[[:space:]]*#.*$//; s/\r$//')"
          [ -z "$line" ] && continue
          # ignorer URL/git/editable entries — on les installera via pip
          case "$line" in
            -e*|git+*|http*|https*|file:*) apt_missing+=("$line") ; continue ;;
          esac

          # extraire le nom du paquet (enlever les contraintes de version)
          pkg_name="$(echo "$line" | sed -E 's/([><=~!].*)$//' | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9+.-].*$//')"
          # essayer les conventions courantes de paquets Debian
          sys_pkg="python3-$pkg_name"

          if run_cmd sudo apt-get install -y "$sys_pkg" >/dev/null 2>&1; then
            echo "Installed via apt: $sys_pkg"
            continue
          fi
          if run_cmd sudo apt-get install -y "$pkg_name" >/dev/null 2>&1; then
            echo "Installed via apt: $pkg_name"
            continue
          fi

          apt_missing+=("$line")
        done < "$req"

        if [ ${#apt_missing[@]} -gt 0 ]; then
          echo "Paquets non trouves via apt pour $req: ${apt_missing[*]}"
          if [ "$INSTALL_PY_METHOD" = "apt" ]; then
            echo "Mode 'apt' force — certains paquets sont introuvables via apt. Ignorés."
            continue
          fi

          # installer les paquets restants via pip
          printf "%s\n" "${apt_missing[@]}" > "$tmpfile"
          if ! python3 -m pip --version >/dev/null 2>&1; then
            echo "pip non disponible — tentative d'installation de pip..."
            run_cmd sudo apt-get install -y python3-pip
          fi
          # Try installing the remaining packages via pip; on failure, create a project venv and retry there.
          if [ "$DRY_RUN" = "true" ]; then
            echo "DRY-RUN: python3 -m pip install -r $tmpfile"
          else
            if [ "$PY_PIP_USER_INSTALL" = "true" ]; then
              if python3 -m pip install --user -r "$tmpfile"; then
                echo "Install via pip (user) successful"
              else
                echo "pip install (user) failed — creation d'un virtualenv local et re-essai"
                python3 -m venv "${GIT_DIR}/borne_arcade/.venv"
                # shellcheck disable=SC1091
                source "${GIT_DIR}/borne_arcade/.venv/bin/activate"
                python -m pip install --upgrade pip
                python -m pip install -r "$tmpfile"
                deactivate || true
              fi
            else
              if python3 -m pip install -r "$tmpfile"; then
                echo "Install via pip successful"
              else
                echo "pip install failed — creation d'un virtualenv local et re-essai"
                python3 -m venv "${GIT_DIR}/borne_arcade/.venv"
                # shellcheck disable=SC1091
                source "${GIT_DIR}/borne_arcade/.venv/bin/activate"
                python -m pip install --upgrade pip
                python -m pip install -r "$tmpfile"
                deactivate || true
              fi
            fi
          fi
          rm -f "$tmpfile"
        fi
      done

    else
      # Méthode pip (ou fallback général)
      echo "Installation via pip des fichiers requirements"
      if ! python3 -m pip --version >/dev/null 2>&1; then
        echo "pip introuvable pour python3 — tentative d'installation via gestionnaire de paquets..."
        case "$PM" in
          apt) run_cmd sudo apt-get install -y python3-pip ;; 
          dnf) run_cmd sudo dnf install -y python3-pip ;; 
          pacman) run_cmd sudo pacman -S --noconfirm python-pip ;;
        esac
      fi

      run_cmd python3 -m pip install --upgrade pip
      for req in "${REQ_FILES[@]}"; do
        if [ "$PY_PIP_USER_INSTALL" = "true" ]; then
          if [ "$DRY_RUN" = "true" ]; then
            echo "DRY-RUN: python3 -m pip install --user -r $req"
          else
            if ! python3 -m pip install --user -r "$req"; then
              echo "pip (user) failed for $req — creation d'un virtualenv local et re-essai"
              python3 -m venv "${GIT_DIR}/borne_arcade/.venv"
              # shellcheck disable=SC1091
              source "${GIT_DIR}/borne_arcade/.venv/bin/activate"
              python -m pip install --upgrade pip
              python -m pip install --user -r "$req" || python -m pip install -r "$req"
              deactivate || true
            fi
          fi
        else
          if [ "$DRY_RUN" = "true" ]; then
            echo "DRY-RUN: python3 -m pip install -r $req"
          else
            if ! python3 -m pip install -r "$req"; then
              echo "pip install failed for $req — creation d'un virtualenv local et re-essai"
              python3 -m venv "${GIT_DIR}/borne_arcade/.venv"
              # shellcheck disable=SC1091
              source "${GIT_DIR}/borne_arcade/.venv/bin/activate"
              python -m pip install --upgrade pip
              python -m pip install -r "$req"
              deactivate || true
            fi
          fi
        fi
      done
    fi
  else
    echo "Installation des dépendances Python ignorée (set INSTALL_PY_REQUIREMENTS=true pour forcer)."
  fi
else
  echo "Aucun fichier requirements.txt trouvé dans le dépôt — aucune dépendance Python à installer."
fi

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

Si vous voulez forcer une JDK précise (par exemple openjdk-8-jdk), exportez JAVA_PKG avant d'exécuter:
  export JAVA_PKG=openjdk-8-jdk && sudo ./install.sh

Si vous voulez forcer une version/paquet Python (par exemple python3.12), exportez PYTHON_PKG avant d'exécuter:
  export PYTHON_PKG=python3.12 && sudo ./install.sh

EOF
