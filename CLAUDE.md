# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a **dotfiles repository** that manages personal development environment configuration for macOS. The repository follows a clean structure separating configuration files by tool/application.

### Key Structure
- `config/` - All configuration files organized by tool
- `private/` - Private/sensitive configurations (e.g., work-specific settings)
- `zsh/` - Shell configuration and scripts
- `Brewfile` - Homebrew dependencies for the entire setup

## Common Development Commands

### Initial Setup
```bash
# Install all dependencies
brew bundle

# This will install:
# - Core shell tools: direnv, mise, starship, zsh
# - Git with diff-so-fancy
# - Terminal: ghostty
# - Development utilities: jq, tree
# - Fonts: FiraCode Nerd Font
```

### Version Management
This setup uses **mise** (config at `config/mise/config.toml`) for managing tool versions:
- Node.js (latest)
- Python (latest) 
- Ruby (3.4)
- Deno (latest)
- Claude Code CLI (latest)

### Shell Environment
- **Shell**: zsh with custom configuration
- **Prompt**: Starship with custom Dracula theme (`config/starship.toml`)
- **Terminal**: Ghostty with custom theming (`config/ghostty/config`)
- **Environment**: direnv for auto-loading project environments

## Configuration Architecture

### Tool Configuration Locations
- **Starship prompt**: `config/starship.toml` - Custom Dracula theme with emojis and git status
- **Ghostty terminal**: `config/ghostty/config` - WildCherry theme with custom keybindings
- **Mise version manager**: `config/mise/config.toml` - Latest versions of development tools
- **Git**:
  - Main config: `config/git/.gitconfig` - Shared git settings and aliases
  - User config: `private/git/user.gitconfig` - Personal info (name, email, signing key)
  - Template: `config/git/user.gitconfig.template` - Template for new setups
- **Private configs**: `private/work.zsh` for work-specific settings

### Custom Features
- **Starship theme**: Custom Dracula palette with emoji-rich git status indicators
- **Ghostty keybindings**: 
  - `cmd+d` / `cmd+shift+d` for pane splitting
  - `cmd+plus/minus/0` for font size control
- **Shell integration**: Full zsh integration with cursor, sudo, and title features

## Development Notes

This is a **configuration-only repository** - no building, testing, or compilation required. Changes take effect through:
- Shell restart for zsh/starship changes
- Terminal restart for ghostty changes  
- `mise install` for version changes

The setup is designed for macOS with Homebrew and assumes FiraCode Nerd Font for proper icon display in the terminal prompt.