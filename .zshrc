# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"
export GOPATH="/home/mcs94/go"
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/${GOPATH//://bin:}/bin

# wayland pycharm
# export _JAVA_AWT_WM_NONREPARENTING=1



eval `keychain --eval --agents gpg,ssh id_rsa`
export PASSWORD_STORE_DIR=$HOME/.pass/team/
alias teampass='PASSWORD_STORE_DIR=~/.pass/team/ pass'
alias sha256sum="shasum -a 256"
alias pswd='date +%s | sha256sum | base64 | head -c 10 ; echo'
alias tunnelme='ssh -D 8123 -f -C -q -N ops-bast'
alias bounceme='ssh -L 5901:localhost:5901 gw02'
alias tldr='f(){ curl -s "cheat.sh/$(echo -n "$*"|jq -sRr @uri)";};f'
alias tfswitch='tfswitch -b ~/bin/terraform'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

# LOAD ANTIGEN — plugin manager
source /usr/share/zsh-antigen/antigen.zsh

# LOAD OH-MY-ZSH
antigen use oh-my-zsh

# OH-MY-ZSH CONFIGURATION
DISABLE_CORRECTION="true"
HIST_STAMPS="yyyy-mm-dd"

# ANTIGEN BUNDLES
antigen bundle aws
antigen bundle command-not-found
antigen bundle git
antigen bundle pyenv
antigen bundle jira
antigen bundle python
antigen bundle fzf
antigen bundle golang
antigen bundle poetry
antigen bundle docker
antigen bundle kubectl
antigen bundle pipenv
antigen bundle tmux
antigen bundle unixorn/autoupdate-antigen.zshplugin
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-autosuggestions
antigen bundle history
antigen bundle pass
antigen apply


eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
load-tfswitch() {
  local tfswitchrc_path=".tfswitchrc"

  if [ -f "$tfswitchrc_path" ]; then
    tfswitch
  fi
}

ttyctl -f

add-zsh-hook chpwd load-tfswitch
load-tfswitch
compinit
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh