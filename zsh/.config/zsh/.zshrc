#!/bin/sh

setopt appendhistory                                      # Append history to the history file (no overwriting)
setopt sharehistory                                       # Share history across terminals
setopt incappendhistory                                   # Immediately append to the history file, not just when a term is killed

# Some useful options (man zshoptions)
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
stty stop undef                                           # disable ctrl-s to freeze terminal
zle_highlight=('paste: none')

# beeping is annoying
unsetopt BEEP

# completions
zstyle ':completion:*' menuselect
zmodload zsh/complist
# compinit
_comp_options+=(globdots)                                 # include hidden files

# if you press up or down during a part of a command, only the commands that start with that part will be shown
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# colors
autoload -Uz colors && colors

# useful functions
source "$ZDOTDIR/functions"

# plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "zsh-users/zsh-completions"
zsh_add_plugin "hlissner/zsh-autopair"
# zsh_add_plugin "spaceship-prompt/spaceship-prompt"

# normal files to source
zsh_add_file "history"
zsh_add_file "aliases"
zsh_add_file "plugins/spaceship-prompt/spaceship.zsh"
zsh_add_file "prompt"

# asdf
. "$ASDF_DIR/asdf.sh"
fpath=(${ASDF_DIR}/completions $fpath) # append asdf completions to fpath

# completions
fpath=(${ZDOTDIR}/plugins/zsh-completions/src $fpath)

#z
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

# load compinit for working completions
zsh_add_file "compinit"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
