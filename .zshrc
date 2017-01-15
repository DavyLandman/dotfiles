


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
zplug "zsh-users/zsh-syntax-highlighting", defer:1
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
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme
DEFAULT_USER='davy'
POWERLEVEL9K_MODE='powerline'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_COLOR_SCHEME='light'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context root_indicator dir )
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs vi_mode)
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""

if ! zplug check; then
    zplug install
fi

zplug load

POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="$(prompt_status left && prompt_vi_mode left && left_prompt_end)"
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


# completion

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'
zstyle ':completion:*' use-cache true
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Directory
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
