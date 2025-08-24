# .dotfiles

Welcome to my dotfiles!

## Setup

**Prerequisites:** macOS + [Homebrew](https://brew.sh/).

### Quick Installation

1. Clone this repository:
```bash
git clone https://github.com/your-username/dotfiles.git ~/dotfiles
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

3. Restart your terminal or source the new config:
```bash
source ~/.zshrc
```

4. Install version-managed tools:
```bash
mise install
```

## What's Included?

### Core Shell
- 🐚 **zsh** - Your new favorite shell
- ⭐ **starship** - The prettiest prompt in the galaxy
- 🔄 **mise** - Version manager that actually works
- 👻 **ghostty** - Lightning-fast terminal emulator
- 🌳 **direnv** - Auto-load environment variables

### Development Essentials
- 🔀 **git** - Version control
- ✨ **diff-so-fancy** - Makes git diffs readable
- 🔍 **jq** - JSON processor
- 🌲 **tree** - See your folders in all their glory

### Fun & Flavour
- 🎨 **FiraCode Nerd Font** - Icons in your terminal!
- 🌈 **Starship config** - Custom prompt with emojis and colors

## Troubleshooting

Something not working?

1. Make sure you're on macOS (this setup is macOS-only)
2. Check that Homebrew is installed: `brew --version`
3. Try running `brew bundle` again
4. Restart your terminal
