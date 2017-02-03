


export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
ZSH=$HOME/.zsh


HISTFILE=$ZSH/history
HISTSIZE=10000
KEYTIMEOUT=23
REPORTTIME=5
SAVEHIST=10000
ZPLUG_CHMOD='chmod --recursive g-w "$ZPLUG_HOME"'
ZPLUG_HOME=$ZSH/zplug

source ~/.zplug/init.zsh

# zplug manages zplug
zplug 'zplug/zplug', hook-build:'zplug --self-manage'


## fancy backwards search
zplug "zsh-users/zsh-history-substring-search", defer:3

## git stuff
zplug "plugins/git",   from:oh-my-zsh

## clipboard for osx (not sure if usefull)
zplug "lib/clipboard", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"


# some fzf search plugin thingy
#zplug "mollifier/anyframe"
# more fzf studd
#zplug "andrewferrier/fzf-z"

## git stuff
zplug "peterhurford/git-aliases.zsh"
GIT_ALIASES_SILENCE_GIT_STATUS=1
zplug "tevren/gitfast-zsh-plugin"

## man pages
zplug "zlsun/solarized-man"
#
## fancy autosuggest based on history
#zplug "zsh-users/zsh-autosuggestions"
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
zplug "sharat87/zsh-vim-mode"
#zplug "b4b4r07/zsh-vimode-visual", use:"*.zsh", defer:3


if [[ $(uname) == Darwin ]]; then
    zplug "$(brew --prefix rbenv)/completions", from:local
    zplug "/usr/local/etc/bash_completion.d", from:local, defer:1
fi

## theme
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme, as:theme, defer:3
DEFAULT_USER='davy'
POWERLEVEL9K_MODE='powerline'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_COLOR_SCHEME='light'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context root_indicator dir )
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs vi_mode)
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_VI_INSERT_MODE_STRING="✎"
POWERLEVEL9K_VI_COMMAND_MODE_STRING=""
POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND='145'
POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND='235'
POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND='254'
POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND='235'


if ! zplug check; then
    zplug install
fi

zplug load

# until #319 is solved, these functions are needed to enable the VI mode prompt
function zle-line-init {
  powerlevel9k_prepare_prompts
  if (( ${+terminfo[smkx]} )); then
    printf '%s' ${terminfo[smkx]}
  fi
  zle reset-prompt
  zle -R
}

function zle-line-finish {
  powerlevel9k_prepare_prompts
  if (( ${+terminfo[rmkx]} )); then
    printf '%s' ${terminfo[rmkx]}
  fi
  zle reset-prompt
  zle -R
}

function zle-keymap-select {
  powerlevel9k_prepare_prompts
  zle reset-prompt
  zle -R
}

zle -N zle-line-init
zle -N ale-line-finish
zle -N zle-keymap-select

POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="$(prompt_status left && left_prompt_end)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias ls='ls -G'
alias l='ls -lF'
alias lt='l -t'
alias ll='lt -a'
alias vi='vim'

export GREP_OPTIONS='--color=auto'
export EDITOR='vim'
export VISUAL='vim'
export HISTCONTROL=erasedups
export JAVA_HOME="`/usr/libexec/java_home -v '1.8*'`"

export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/local/lib:/opt/X11/lib/pkgconfig
export MONO_GAC_PREFIX="/usr/local"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
  fpath=(/usr/local/share/zsh-completions $fpath)


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

if [ -f ~/.zsh_secrets ]; then
    source ~/.zsh_secrets
fi
if [ -f "$HOME/cacert.pem" ]; then
    export SSL_CERT_FILE="$HOME/cacert.pem"
fi
