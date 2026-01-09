# setopts

setopt correct # Auto Correct prompts
setopt no_beep # Stops Terminal Beeps
setopt extended_glob # Allows extended globbing patterns ** * 

# Paths 

export PATH="$HOME/.local/bin:$PATH"

# Completion
autoload -Uz compinit
compinit -C

# cd stack

setopt auto_pushd
setopt pushd_ignore_dups

# Zinit installation

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

source "${ZINIT_HOME}/zinit.zsh"

# Plugins

zinit ice wait"1" lucid
zinit light zsh-users/zsh-autosuggestions

zinit ice wait"1" lucid
zinit light jeffreytse/zsh-vi-mode

zinit light zsh-users/zsh-completions

zinit light zsh-users/zsh-syntax-highlighting

# Starship Prompt setup

if command -v starship >/dev/null; 
    then eval "$(starship init zsh)" 
fi

# export MANPATH="/usr/local/man:$MANPATH"
export MANPAGER='nvim +Man!'

alias vim="nvim"
alias vi="nvim"
alias ls="ls --color=auto"
alias ll="ls -alF --color=auto"
alias la="ls -A --color=auto"
alias l="ls -CF --color=auto"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
