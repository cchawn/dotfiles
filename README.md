# .dotfiles

Personal development environment configuration for macOS.

## Setup

**Prerequisites:** macOS + [Homebrew](https://brew.sh/) + [1Password for SSH & Git](https://developer.1password.com/docs/ssh/).

### Quick Installation

1. Clone this repository:

```bash
git clone git@github.com:cchawn/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

2. Run the installation script:

```bash
./install.sh
```

The script will:

- Install all Homebrew dependencies from the Brewfile
- Create symlinks for all configuration files
- Back up any existing files before linking
- Set up proper directory structure

3. Restart your terminal or source the config:

```bash
source ~/.zshrc
```

4. Install version-managed tools:

```bash
mise install
```

## What's Included?

### Core Shell

- 🐚 **zsh** - Shell with plugins (autosuggestions, syntax highlighting)
- ⭐ **starship** - Custom prompt with Dracula theme + emojis 👸
- 🔄 **mise** - Version manager for dev tools
- 👻 **ghostty** - Terminal emulator
- 🌳 **direnv** - Auto-load environment variables
- 🔍 **fzf** - Fuzzy finder

### Development Tools

- 🔀 **git** + **diff-so-fancy** - Version control with readable diffs
- 🐙 **gh** - GitHub CLI
- 📋 **jq** - JSON processor
- 🌲 **tree** - Directory listing
- 🤖 **Claude Code** - agentic coding tool

## Troubleshooting

1. Ensure macOS and Homebrew are installed: `brew --version`
2. Re-run `brew bundle` if dependencies are missing
3. Restart your terminal after installation
