#!/usr/bin/env bash

set -e

DOTFILES="$HOME/.dotfiles"
BACKUP="$HOME/.backup_dotfiles_$(date +%Y%m%d_%H%M%S)"
CONFIG="$HOME/.config"

mkdir -p "$BACKUP"

echo "📦 Backup location: $BACKUP"

# Backup helper
backup() {
  local target="$1"
  if [ -e "$target" ] || [ -L "$target" ]; then
    local rel="${target#$HOME/}"
    local dest="$BACKUP/$rel"
    mkdir -p "$(dirname "$dest")"
    mv "$target" "$dest"
    echo "🗃️  Backed up $target → $dest"
  fi
}

# Link helper: backups and then links
link() {
  local source="$1"
  local dest="$2"

  backup "$dest"
  ln -snf "$source" "$dest"
  echo "🔗 Linked $dest → $source"
}

echo "🔧 Installing dotfiles..."

# Home-level dotfiles
link "$DOTFILES/.zshrc" "$HOME/.zshrc"
link "$DOTFILES/.zprofile" "$HOME/.zprofile"
link "$DOTFILES/.tmux.conf" "$HOME/.tmux.conf"

# tmux folder
link "$DOTFILES/.tmux" "$HOME/.tmux"

# Config subdirectories
mkdir -p "$CONFIG"
link "$DOTFILES/.config/nvim" "$CONFIG/nvim"
link "$DOTFILES/.config/mise" "$CONFIG/mise"
link "$DOTFILES/.config/ghostty" "$CONFIG/ghostty"

# Backup .local/share apps that will be replaced
LOCAL_SHARE="$HOME/.local/share"
mkdir -p "$BACKUP/.local/share"

for dir in mise nvim tmux ghostty zsh; do
  if [ -d "$LOCAL_SHARE/$dir" ]; then
    mv "$LOCAL_SHARE/$dir" "$BACKUP/.local/share/$dir"
    echo "📂 Backed up ~/.local/share/$dir → $BACKUP/.local/share/$dir"
  fi
done

echo "✅ Dotfiles installation complete."
