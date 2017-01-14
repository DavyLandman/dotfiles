alias ls='ls -G'
alias l='ls -lF'
alias lt='l -t'
alias ll='lt -a'
alias vi='vim'

BREWPREFIX=`brew --prefix`

if [ -f "$BREWPREFIX/etc/bash_completion.d/git-completion.bash"  ]; then
    # shellcheck source=/dev/null
	. $BREWPREFIX/etc/bash_completion.d/git-completion.bash 
fi
if [ -f $BREWPREFIX/etc/bash_completion.d/hub.bash_completion.sh  ]; then
    # shellcheck source=/dev/null
	. $BREWPREFIX/etc/bash_completion.d/hub.bash_completion.sh 
fi
if [ -f "$BREWPREFIX/etc/bash_completion" ]; then
    # shellcheck source=/dev/null
	. $BREWPREFIX/etc/bash_completion
fi
if [ -d $BREWPREFIX/share/git-core/contrib/subtree ]; then
	export PATH=$BREWPREFIX/share/git-core/contrib/subtree:$PATH
fi
export PATH=/usr/local/share/npm/bin:$PATH
export JAVA_HOME="`/usr/libexec/java_home -v '1.8*'`"
# make sure we have the english bash
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

bind "set completion-ignore-case on"

export GREP_OPTIONS='--color=auto'
export EDITOR='vim'
export VISUAL='vim'
export CLICOLOR=1
export HISTSIZE=10000
export HISTCONTROL=erasedups
set -o vi # vi mode

#function color_my_prompt {
#    local __reset_color="\[\033[0m\]"
#    local __user_and_host="\[\033[33m\]laptop$__reset_color:\[\033[32m\]\u"
#    local __cur_location="\[\033[36m\]\w\[\033[0m\]"
#    local __git_branch_color="\[\033[31m\]"
#    #local __git_branch="\`ruby -e \"print (%x{git branch 2> /dev/null}.grep(/^\*/).first || '').gsub(/^\* (.+)$/, '(\1) ')\"\`"
#    local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\ \(\\\\\1\)/`'
#    export PS1="[$__user_and_host$__reset_color]-[$__cur_location$__git_branch_color$__git_branch$__reset_color]\n$ "
#}
#color_my_prompt

if [ -f "$BREWPREFIX/etc/bash_completion.d/git-prompt.sh" ]; then
    # shellcheck source=/dev/null
    source "$BREWPREFIX/etc/bash_completion.d/git-prompt.sh"
    __reset_color="\[\033[0m\]"
    __user_and_host="\[\033[33m\]laptop$__reset_color:\[\033[32m\]\u"
    __cur_location="\[\033[36m\]\w\[\033[0m\]"
    __git_branch_color="\[\033[31m\]"
    export PS1="[$__user_and_host$__reset_color]-[$__cur_location$__git_branch_color\$(__git_ps1 ' (%s)')$__reset_color]\n$ "
    #export GIT_PS1_SHOWUPSTREAM="auto"
    #export GIT_PS1_SHOWCOLORHINTS="yes"
    #export GIT_PS1_SHOWDIRTYSTATE="yes"
fi

#PS1="[laptop@\[\e[1m\]\w\[\e[m\]]\n$ "
#[ -z "$PS1" ] || export PS1="[\[\033[33m\]laptop\[\033[0m\]:\[\033[32m\]\u\[\033[0m\]]-[\[\033[36m\]\w\[\033[0m\]$(__git_ps1 " (%s)")]\n$ "  
export PROMPT_COMMAND='echo -e "\033];`basename $PWD`\007"'

[[ -s "/Users/davy/.rvm/scripts/rvm" ]] && source "/Users/davy/.rvm/scripts/rvm"  # This loads RVM into a shell session.

export ANDROID_SDK_ROOT=/usr/local/opt/android-sdk

export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/local/lib:/opt/X11/lib/pkgconfig
export PATH=$PATH:/usr/local/infer-osx-v0.1.0/infer/infer/bin
export MONO_GAC_PREFIX="/usr/local"

# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'



[ -f ~/.fzf.bash ] && source ~/.fzf.bash
