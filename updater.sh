#!/bin/bash
# Script de mise à jour automatique pour la borne arcade et Galad-Scott
# Retourne 0 si au moins une mise à jour a été effectuée, 1 sinon

set -e

# Déterminer le répertoire de la borne (où se trouve ce script)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BORNE_DIR="$SCRIPT_DIR"
GALAD_SCOTT_DIR="$BORNE_DIR/projet/Galad-Scott"
LOG_FILE="$BORNE_DIR/updater.log"
STASH_REMINDER_FILE="$BORNE_DIR/.stash_reminder"
UPDATED=false

# Supprimer l'ancien fichier de rappel s'il existe
rm -f "$STASH_REMINDER_FILE"

# Fonction pour logger avec timestamp
log_message() {
  local message="$1"
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $message" | tee -a "$LOG_FILE"
}

# Fonction pour vérifier et mettre à jour un dépôt git
update_repository() {
  local name="$1"
  local dir="$2"
  
  log_message "=== Vérification de $name ==="
  
  # Vérifier si c'est un dépôt git
  if [ ! -d "$dir/.git" ]; then
    log_message "❌ Aucune source git pour $name (dossier: $dir)"
    return 1
  fi

  # Vérifier que git est disponible
  if ! command -v git >/dev/null 2>&1; then
    log_message "❌ git introuvable, mise à jour ignorée pour $name"
    return 1
  fi

  # Vérifier la configuration upstream
  local upstream
  upstream=$(git -C "$dir" rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null || true)
  if [ -z "$upstream" ]; then
    log_message "⚠️  Aucun upstream configuré pour $name"
    return 1
  fi

  # Fetch les dernières modifications
  log_message "🔄 Récupération des dernières modifications..."
  if ! git -C "$dir" fetch --quiet 2>/dev/null; then
    log_message "❌ Échec du fetch pour $name"
    return 1
  fi

  # Comparer les révisions
  local local_rev remote_rev base_rev
  local_rev=$(git -C "$dir" rev-parse HEAD)
  remote_rev=$(git -C "$dir" rev-parse "$upstream")
  base_rev=$(git -C "$dir" merge-base HEAD "$upstream")

  # Déjà à jour
  if [ "$local_rev" = "$remote_rev" ]; then
    log_message "✅ $name est déjà à jour"
    return 1
  fi

  # Changements disponibles en amont
  if [ "$local_rev" = "$base_rev" ]; then
    log_message "🆕 Mise à jour disponible pour $name"
    
    # Gérer les modifications locales non commitées
    local stashed=false
    if [ -n "$(git -C "$dir" status --porcelain)" ]; then
      log_message "📦 Modifications locales détectées — sauvegarde dans stash"
      local stash_output
      stash_output=$(git -C "$dir" stash push -u -m "Sauvegarde avant MAJ - $(date '+%Y-%m-%d %H:%M:%S')" 2>&1) || true
      
      if echo "$stash_output" | grep -q "No local changes to save"; then
        stashed=false
      else
        stashed=true
        log_message "✅ Modifications sauvegardées dans le stash"
        log_message "⚠️  Vos modifications locales sont préservées dans le stash"
        log_message "    Pour les récupérer : git -C \"$dir\" stash pop"
      fi
    fi

    # Effectuer le pull avec rebase
    log_message "⬇️  Application de la mise à jour..."
    if git -C "$dir" pull --rebase --quiet 2>/dev/null; then
      log_message "✅ $name mis à jour avec succès"
      UPDATED=true
      
      # Avertir l'utilisateur si des modifications ont été stashées
      if [ "$stashed" = true ]; then
        log_message ""
        log_message "╔════════════════════════════════════════════════════╗"
        log_message "║   ⚠️  ATTENTION : Modifications locales stashées  ║"
        log_message "╚════════════════════════════════════════════════════╝"
        log_message "Vos modifications pour $name ont été sauvegardées."
        log_message "Pour les récupérer après la borne :"
        log_message "  cd $dir"
        log_message "  git stash list"
        log_message "  git stash pop"
        log_message ""
      fi
      
      return 0
    else
      log_message "❌ Échec de la mise à jour pour $name"
      
      # Restaurer le stash en cas d'échec
      if [ "$stashed" = true ]; then
        log_message "🔄 Restauration des modifications locales suite à l'échec..."
        if git -C "$dir" stash pop --quiet 2>/dev/null; then
          log_message "✅ Modifications restaurées"
        else
          log_message "⚠️  Impossible de restaurer automatiquement le stash"
        fi
      fi
      
      return 1
    fi
  fi

  # Branches divergées
  if [ "$remote_rev" = "$base_rev" ]; then
    log_message "⚠️  $name est en avance sur l'upstream (aucune mise à jour nécessaire)"
    return 1
  fi

  # Branches complètement divergées
  log_message "⚠️  $name a divergé de l'upstream (mise à jour manuelle requise)"
  return 1
}

# Début de la procédure de mise à jour
log_message ""
log_message "╔════════════════════════════════════════════════════╗"
log_message "║   Démarrage du processus de mise à jour           ║"
log_message "╚════════════════════════════════════════════════════╝"

# Mise à jour de la borne arcade
if update_repository "borne_arcade" "$BORNE_DIR"; then
  log_message "✅ borne_arcade mise à jour"
fi

# Mise à jour de Galad-Scott
if [ -d "$GALAD_SCOTT_DIR" ]; then
  if update_repository "Galad-Scott" "$GALAD_SCOTT_DIR"; then
    log_message "✅ Galad-Scott mis à jour"
  fi
else
  log_message "⚠️  Galad-Scott absent du répertoire projet/"
fi

# Résumé final
log_message ""
log_message "╔════════════════════════════════════════════════════╗"
if [ "$UPDATED" = true ]; then
  log_message "║   ✅ Mises à jour appliquées avec succès          ║"
  log_message "╚════════════════════════════════════════════════════╝"
  
  # Vérifier s'il y a des stash dans les dépôts
  local has_stash=false
  if [ -d "$BORNE_DIR/.git" ]; then
    if [ -n "$(git -C "$BORNE_DIR" stash list 2>/dev/null)" ]; then
      has_stash=true
      log_message ""
      log_message "📦 Modifications stashées dans borne_arcade :"
      git -C "$BORNE_DIR" stash list | head -n 3 | while read -r line; do
        log_message "   $line"
      done
      # Ajouter au fichier de rappel
      {
        echo "📦 MODIFICATIONS STASHÉES DANS BORNE_ARCADE :"
        echo ""
        git -C "$BORNE_DIR" stash list
        echo ""
        echo "Pour récupérer : cd $BORNE_DIR && git stash pop"
        echo ""
      } >> "$STASH_REMINDER_FILE"
    fi
  fi
  if [ -d "$GALAD_SCOTT_DIR/.git" ]; then
    if [ -n "$(git -C "$GALAD_SCOTT_DIR" stash list 2>/dev/null)" ]; then
      has_stash=true
      log_message ""
      log_message "📦 Modifications stashées dans Galad-Scott :"
      git -C "$GALAD_SCOTT_DIR" stash list | head -n 3 | while read -r line; do
        log_message "   $line"
      done
      # Ajouter au fichier de rappel
      {
        echo "📦 MODIFICATIONS STASHÉES DANS GALAD-SCOTT :"
        echo ""
        git -C "$GALAD_SCOTT_DIR" stash list
        echo ""
        echo "Pour récupérer : cd $GALAD_SCOTT_DIR && git stash pop"
        echo ""
      } >> "$STASH_REMINDER_FILE"
    fi
  fi
  
  if [ "$has_stash" = true ]; then
    log_message ""
    log_message "💡 Pour récupérer vos modifications : git stash pop"
    log_message "📄 Rappel sauvegardé dans : $STASH_REMINDER_FILE"
  fi
  
  exit 0
else
  log_message "║   ℹ️  Aucune mise à jour nécessaire                ║"
  log_message "╚════════════════════════════════════════════════════╝"
  exit 1
fi
