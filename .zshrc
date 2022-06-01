alias l='ls -GwF'
alias ll='ls -alh'
alias tfswitch='tfswitch -b /Users/kbhm220/bin/terraform'
alias lg='lazygit'
alias md5sum='md5 -r'
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
bindkey '^[[Z' reverse-menu-complete

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /Users/kbhm220/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /Users/kbhm220/.zsh/completion.zsh
source /Users/kbhm220/.zsh/zsh-autoswitch-virtualenv/autoswitch_virtualenv.plugin.zsh
# Initialize the completion system
autoload -Uz compinit

# Cache completion if nothing changed - faster startup time
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

# Enhanced form of menu completion called `menu selection'
zmodload -i zsh/complist

export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
export PATH=$PATH:/Users/kbhm220/bin

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

eval "$(pyenv init -)"

load-tfswitch() {
  local tfswitchrc_path=".tfswitchrc"

  if [ -f "$tfswitchrc_path" ]; then
    tfswitch
  fi
}
add-zsh-hook chpwd load-tfswitch
load-tfswitch
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /Users/kbhm220/bin/nomad-pack nomad-pack
