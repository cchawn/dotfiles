######################
# User configuration #
######################

# aliases
alias be="bundle exec"
alias g="git"

# direnv
eval "$(direnv hook zsh)"

# mise
eval "$(mise activate zsh)"

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
