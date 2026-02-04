#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

log() {
    echo "🔧 $1"
}

error() {
    echo "❌ $1" >&2
    exit 1
}

backup_existing() {
    local target="$1"
    if [[ -e "$target" || -L "$target" ]]; then
        log "Backing up existing $target to $BACKUP_DIR"
        mkdir -p "$BACKUP_DIR"
        mv "$target" "$BACKUP_DIR/"
    fi
}

create_symlink() {
    local source="$1"
    local target="$2"
    
    log "Linking $source -> $target"
    backup_existing "$target"
    mkdir -p "$(dirname "$target")"
    ln -sf "$source" "$target"
}

main() {
    log "Starting dotfiles installation from $DOTFILES_DIR"
    
    # Install Homebrew dependencies
    if command -v brew &> /dev/null; then
        log "Installing Homebrew dependencies..."
        brew bundle --file="$DOTFILES_DIR/Brewfile"
    else
        echo "⚠️  Homebrew not found. Please install Homebrew first:"
        echo "   /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        echo "   Then run this script again."
        exit 1
    fi
    
    # Zsh configuration
    create_symlink "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
    
    # Git configuration
    create_symlink "$DOTFILES_DIR/config/git/.gitconfig" "$HOME/.gitconfig"
    create_symlink "$DOTFILES_DIR/config/git/.gitignore_global" "$HOME/.gitignore_global"

    # Git user configuration (personal info)
    if [[ ! -f "$DOTFILES_DIR/private/git/user.gitconfig" ]]; then
        log "Creating user git config from template..."
        mkdir -p "$DOTFILES_DIR/private/git"
        if [[ -f "$DOTFILES_DIR/config/git/user.gitconfig.template" ]]; then
            cp "$DOTFILES_DIR/config/git/user.gitconfig.template" "$DOTFILES_DIR/private/git/user.gitconfig"
            echo "⚠️  Please edit $DOTFILES_DIR/private/git/user.gitconfig with your git user details"
        else
            error "Template file not found at $DOTFILES_DIR/config/git/user.gitconfig.template"
        fi
    fi

    if [[ -f "$DOTFILES_DIR/private/git/user.gitconfig" ]]; then
        create_symlink "$DOTFILES_DIR/private/git/user.gitconfig" "$HOME/.gitconfig.user"
    fi
    
    # Starship prompt
    create_symlink "$DOTFILES_DIR/config/starship.toml" "$HOME/.config/starship.toml"
    
    # Ghostty terminal
    create_symlink "$DOTFILES_DIR/config/ghostty/config" "$HOME/.config/ghostty/config"
    
    # Mise version manager
    create_symlink "$DOTFILES_DIR/config/mise/config.toml" "$HOME/.config/mise/config.toml"

    # Claude Code CLI
    if ! command -v claude &> /dev/null; then
        read -p "🤖 Install Claude Code CLI? [y/N] " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            log "Installing Claude Code CLI..."
            curl -fsSL https://claude.ai/install.sh | bash
        else
            log "Skipping Claude Code CLI installation"
        fi
    else
        log "Claude Code CLI already installed"
    fi

    # Zed editor
    create_symlink "$DOTFILES_DIR/config/zed/settings.json" "$HOME/.config/zed/settings.json"

    # Claude Code configuration (if it exists)
    if [[ -f "$DOTFILES_DIR/config/claude/CLAUDE.md" ]]; then
        create_symlink "$DOTFILES_DIR/config/claude" "$HOME/.claude"
    fi
    
    # Source private configurations if they exist
    if [[ -d "$DOTFILES_DIR/private" ]]; then
        log "Private directory found - symlinking private configs"
        for private_file in "$DOTFILES_DIR/private"/*; do
            if [[ -f "$private_file" && "$private_file" != */.keep ]]; then
                filename=$(basename "$private_file")
                create_symlink "$private_file" "$HOME/.config/private/$filename"
            fi
        done
    fi
    
    log "Installation complete! 🎉"
    log ""
    log "Next steps:"
    log "1. Restart your terminal or run: source ~/.zshrc"
    log "2. Install mise-managed tools: mise install"
    log "3. If you use private configs, add them to the private/ directory"
    log ""
    if [[ -d "$BACKUP_DIR" ]]; then
        log "Your original files were backed up to: $BACKUP_DIR"
    fi
}

main "$@"