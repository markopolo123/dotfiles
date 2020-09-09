# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# wayland pycharm
# export _JAVA_AWT_WM_NONREPARENTING=1

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"

eval `keychain --eval --agents gpg,ssh id_rsa`
export PASSWORD_STORE_DIR=$HOME/.pass/team/

# ALIAS
source ~/.config/.alias



# LOAD ANTIGEN — plugin manager
source ${HOME}/antigen.zsh

# Load ANTIGEN configuration
antigen init ${HOME}/.config/.antigenrc

# OH-MY-ZSH CONFIGURATION
DISABLE_CORRECTION="true"
HIST_STAMPS="yyyy-mm-dd"

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