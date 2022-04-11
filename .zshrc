# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Theme
ZSH_THEME="wild-cherry"

# Command auto-correction.
ENABLE_CORRECTION="true"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Plugins
plugins=(git z zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Extend bash profile
source ~/.bash_profile

# Aliases
. ~/.zsh_aliases

# Vars
export PATH="/usr/local/opt/libxml2/bin:$PATH"
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
export CPPFLAGS=-I/usr/local/opt/imagemagick@6/include
export PKG_CONFIG_PATH=/usr/local/opt/imagemagick@6/lib/pkgconfig
export LDFLAGS=-L/usr/local/opt/imagemagick@6/lib
export GITHUB_PACKAGES_TOKEN="REPLACE_ME"
export GITHUB_API_TOKEN="REPLACE_ME"

# https://github.com/junegunn/fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# https://direnv.net/
eval "$(direnv hook zsh)"
