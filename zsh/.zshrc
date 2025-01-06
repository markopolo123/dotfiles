alias l='ls -GwF'
alias ll='ls -alh'
alias lg='lazygit'
alias tfswitch='tfswitch -b /Users/$USER/bin/terraform'
alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'

eval "$(starship init zsh)"
eval "$(direnv hook zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
bindkey '^[[Z' reverse-menu-complete


set -o autopushd
zstyle ':completion:*' format ''
zstyle ':completion:*' menu select=2

# Initialize the completion system
autoload -Uz compinit

# Cache completion if nothing changed - faster startup time
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

source $(brew --prefix)/share/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh
antigen bundle git
antigen bundle fzf
antigen bundle pyenv
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle pip
antigen bundle direnv
antigen bundle autojump
antigen bundle zsh-users/zsh-autosuggestions

antigen apply
# Enhanced form of menu completion called `menu selection'
zmodload -i zsh/complist

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
export PATH=$PATH:/Users/$USER/bin

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"


load-tfswitch() {
  local tfswitchrc_path=".tfswitchrc"
  if [ -f "$tfswitchrc_path" ]; then
    tfswitch
  fi
}

add-zsh-hook chpwd load-tfswitch
load-tfswitch
export GOPATH="/Users/msh/go/"
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/opt/openjdk@8/bin:$PATH"
export PATH="/Users/msh/go/bin:$PATH"
export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
eval "$(zoxide init --cmd cd zsh)"
eval "$(atuin init zsh)"
