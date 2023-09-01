#!/bin/sh

source "$ZDOTDIR/zsh-aliases"
# some useful options (man zshoptions)
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
stty stop undef		# Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

# beeping is annoying
unsetopt BEEP

# completions
autoload -Uz compinit
zstyle ':completion:*' menu select
# zstyle ':completion::complete:lsof:*' menu yes select
zmodload zsh/complist
compinit

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Colors
autoload -Uz colors && colors

# Useful Functions
source "$ZDOTDIR/zsh-functions"

# Normal files to source
zsh_source_file "zsh-exports"
zsh_source_file "zsh-vim-mode"
zsh_source_file "zsh-aliases"
zsh_source_file "zsh-prompt"
zsh_source_file "zsh-keybindings"
zsh_source_file "zsh-commands"

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "zsh-users/zsh-history-substring-search"
zsh_add_plugin "akash329d/zsh-alias-finder"
zsh_add_plugin "sei40kr/zsh-fast-alias-tips"
# zsh_add_completion "srijanshetty/zsh-pip-completion" false
# zsh_add_completion "zsh-users/zsh-completions" false
# zsh_add_completion "esc/conda-zsh-completion" false
# For more plugins: https://github.com/unixorn/awesome-zsh-plugins
# More completions https://github.com/zsh-users/zsh-completions

################
# Key-bindings #
################
bindkey -s '^o' 'ranger\n'
bindkey -s '^f' 'zi\n'
# bindkey -s '^s' 'ncdu\n'
bindkey -s '^v' 'nvim\n'
# bindkey -s '^z' 'zi\n'
bindkey '^[[P' delete-char
bindkey "^p" up-line-or-beginning-search # Up
bindkey "^n" down-line-or-beginning-search # Down
bindkey "^r" history-incremental-search-backward 
# zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# zsh-autosuggestions
bindkey '^ ' autosuggest-accept


alias lll="ls -al"



# FZF
# Todo: theses files do not exists
# source /usr/share/fzf/key-bindings.zsh
# source /usr/share/fzf/completion.zsh
export FZF_DEFAULT_COMMAND='rg --hidden -l ""'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
