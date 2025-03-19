# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

######################
# User configuration #
######################

# aliases
alias be="bundle exec"
alias g="git"

# direnv
eval "$(direnv hook zsh)"

# ws-cli
eval "$(ws hook zsh)"

source /Users/cchan/.config/wealthsimple/rbenv/config.zsh
source /Users/cchan/.config/wealthsimple/direnv/config.zsh
source /Users/cchan/.config/wealthsimple/nvm/config.zsh
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"


# brew install zsh-autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# brew install fzf
source <(fzf --zsh)

eval "$(starship init zsh)"
