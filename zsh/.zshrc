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
# Helper functions   #
######################

# docker ECR login
docker_login_to_aws_ecr() {
  local ecr_url="$1"
  local region="$2"
  local login_output

  login_output=$(aws ecr get-login-password --region "$region" 2>&1 | \
    docker login --username AWS --password-stdin "$ecr_url" 2>&1)
  local login_status=$?

  if [ $login_status -ne 0 ]; then
    echo "❌ Docker login to AWS ECR failed."
    echo "$login_output"
    echo "💡 You may need to 'assume' your AWS role before logging in."
    return $login_status
  else
    local current_role
    echo "✅ Docker login to AWS ECR succeeded."
    echo "   ECR URL: $ecr_url"
    echo "   Region: $region"
    echo "   Profile: ${AWS_PROFILE:-default}"
  fi
}

######################
# Work configuration #
######################
if [[ -f /Users/cchan/Workspace/dotfiles/private/work.zsh ]]; then
  source /Users/cchan/Workspace/dotfiles/private/work.zsh
fi
