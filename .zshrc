zmodload zsh/zprof
export PATH="/c/Program Files/OpenSSH:/cmd:$PATH"
#export PATH="/cmd:$PATH"
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
ZSH=$HOME/.zsh


HISTFILE=$ZSH/history
HISTSIZE=10000
KEYTIMEOUT=23
REPORTTIME=5
SAVEHIST=10000
ZPLUG_CHMOD='chmod -R g-w "$ZPLUG_HOME"'
ZPLUG_HOME=$ZSH/zplug

source ~/.zplug/init.zsh

# zplug manages zplug
zplug 'zplug/zplug', hook-build:'zplug --self-manage'


## fancy backwards search
zplug "zsh-users/zsh-history-substring-search", defer:3

## git stuff
#zplug "plugins/git",   from:oh-my-zsh
zplug "plugins/gitfast",   from:oh-my-zsh

## clipboard for osx (not sure if usefull)
zplug "lib/clipboard", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"

## git stuff
#zplug "peterhurford/git-aliases.zsh"

## man pages
zplug "zlsun/solarized-man"
#
## fancy autosuggest based on history
zplug "zsh-users/zsh-autosuggestions"
#
## file browsing
#zplug "vifon/deer", use:deer
#
## fancy colors for listings
zplug "supercrabtree/k"
#
#
#
## zsh stuff
zplug "zsh-users/zsh-completions", hook-build:$ZPLUG_CHMOD
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "chrissicool/zsh-256color"
# zsh title in terminal
zplug "jreese/zsh-titles"

# vim mode
#zplug "softmoth/zsh-vim-mode"
#zplug "sharat87/zsh-vim-mode"
#zplug "jeffreytse/zsh-vi-mode"
zplug "plugins/vi-mode",   from:oh-my-zsh
#zplug "b4b4r07/zsh-vimode-visual", use:"*.zsh", defer:3

# docker stuff
zplug "docker/compose", use:contrib/completion/zsh


if [[ $(uname) == Darwin ]]; then
    zplug "$(brew --prefix rbenv)/completions", from:local
    zplug "/usr/local/etc/bash_completion.d", from:local, defer:1
    fpath=(/usr/local/share/zsh-completions $fpath)
fi

## theme

#zplug "romkatv/powerlevel10k", use:powerlevel10k.zsh-theme, as:theme, defer:3, depth:1
#zplug "jackharrisonsherlock/common", use:common.zsh-theme, as:theme, defer:3, depth:1
zplug mafredri/zsh-async, from:github

zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme, at:main
#zplug jackharrisonsherlock/common, as:theme


PURE_GIT_PULL=0
PURE_CMD_MAX_EXEC_TIME=2

DEFAULT_USER='davy'

VI_MODE_SET_CURSOR=true
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true


if ! zplug check; then
    zplug install
fi

zplug load


zle -N zle-line-init
zle -N ale-line-finish
zle -N zle-keymap-select

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ $(uname) == Darwin ]]; then
    alias ls='ls -G'
else
    alias ls='ls --color=auto'
fi
alias l='ls -lF'
alias lt='l -t'
alias ll='lt -a'
alias vi='vim'

alias grep='grep --color=auto'
export EDITOR='vim'
export VISUAL='vim'
export HISTCONTROL=erasedups

if [[ $(uname) == Darwin ]]; then
    export JAVA_HOME="`/usr/libexec/java_home -v '1.8*'`"

    export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/local/lib:/opt/X11/lib/pkgconfig
    export MONO_GAC_PREFIX="/usr/local"
fi
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting


# completion

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'
zstyle ':completion:*' use-cache true
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Directory
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
if [[ $(uname) == Darwin ]]; then
    export PATH="/usr/local/opt/python/libexec/bin:$PATH"
fi
export MONO_GAC_PREFIX="/usr/local"


if [ -f ~/.zsh_secrets ]; then
    source ~/.zsh_secrets
fi
if [ -f "$HOME/cacert.pem" ]; then
    export SSL_CERT_FILE="$HOME/cacert.pem"
fi

# explicitly bind reverse search to control-r
#bindkey '^R' history-incremental-pattern-search-backward

export PATH="$PATH:$HOME/go/bin:$(go env GOPATH)/bin"

# env=~/.ssh/agent.env
# 
# agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }
# 
# agent_start () {
#     (umask 077; ssh-agent >| "$env")
#     . "$env" >| /dev/null ; }
# 
# agent_load_env
# 
# # agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
# 
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)



if [ $agent_run_state = 2 ]; then
    echo "Starting ssh-agent and adding key"
    ssh-add
elif [ $agent_run_state = 1 ]; then
    echo "Reusing ssh-agent and adding key"
    ssh-add
elif [ $agent_run_state = 0 ]; then
    echo "Reusing ssh-agent and reusing key"
    ssh-add -l
fi


## git ssh fake stuff

#git_ssh_env=~/.ssh/git-agent.env
# 
#agent_load_env () { test -f "$git_ssh_env" && . "$git_ssh_env" >| /dev/null ; }
#
#agent_start () {
#     (umask 077; /usr/bin/ssh-agent >| "$git_ssh_env")
#     . "$git_ssh_env" >| /dev/null ; }
# 
#agent_load_env
# 
#
#agent_run_state=$(/usr/bin/ssh-add -l >| /dev/null 2>&1; echo $?)
#if [ $agent_run_state = 2 ]; then
#    echo "Starting git-ssh-agent and adding key"
#    agent_start
#    /usr/bin/ssh-add ~/.ssh/id_ed25519
#elif [ $agent_run_state = 1 ]; then
#    echo "Reusing git-ssh-agent and adding key"
#    /usr/bin/ssh-add ~/.ssh/id_ed25519
#elif [ $agent_run_state = 0 ]; then
#    echo "Reusing git-ssh-agent and reusing key"
#    /usr/bin/ssh-add -l
#fi


    unset env

export GIT_SSH_COMMAND='c:\\Program\ Files\\OpenSSH\\ssh.exe'
#export GIT_SSH_COMMAND="ssh"

source <(hcloud completion zsh)

#export SSH_SK_PROVIDER=/usr/lib/winhello.dll

# Control + backspace
bindkey '^H' backward-kill-word
