######################
# User configuration #
######################

# aliases
alias be="bundle exec"
alias g="git"

# direnv
eval "$(direnv hook zsh)"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

eval "$(starship init zsh)"

###################
# zsh packages    #
###################

# brew install zsh-autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# brew install zsh-syntax-highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# brew install fzf
source <(fzf --zsh)

######################
# Work configuration #
######################
source /Users/cchan/Workspace/dotfiles/private/work.zsh
