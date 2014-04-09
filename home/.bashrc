# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi


# set a fancy prompt (non-color, unless we know we "want" color)
# also set it based on a hash of the hostname
__hostname_color=$((31 + $(hostname | cksum | cut -c1-3) % 6))
case "$TERM" in
xterm-color|screen|screen-256color|xterm|xterm-256color)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;${__hostname_color}m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;36m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
*)
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
esac

# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
#    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
export EDITOR=emacs

# avoid losing history
# http://wooledge.org:8000/BashFAQ/088
unset HISTFILESIZE
HISTSIZE=10000
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
export HISTSIZE PROMPT_COMMAND

shopt -s histappend

# ignore history lines with space in them
declare -x HISTCONTROL=ignorespace
shopt -s histappend


# see http://emacs-fu.blogspot.com.au/2011/12/system-administration-with-emacs.html
# added 21/05/12
# edit file with root privs
function E() {
    filename=$1
    without_beg_slash="${1##/}"
    if [[ $without_beg_slash == $1 ]];then
        filename="${PWD%//}/$1"
    fi
    emacsclient -c -a emacs "/sudo:root@localhost:$filename"
}

export PATH="$PATH:~/source/ecukes"
test -f ~/perl5/perlbrew/etc/bashrc && source ~/perl5/perlbrew/etc/bashrc

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export PERL_LOCAL_LIB_ROOT="/home/jason/perl5:$PERL_LOCAL_LIB_ROOT";
export PERL_MB_OPT="--install_base "/home/jason/perl5"";
export PERL_MM_OPT="INSTALL_BASE=/home/jason/perl5";
export PERL5LIB="/home/jason/perl5/lib/perl5:$PERL5LIB";
export PATH="/home/jason/perl5/bin:$PATH";

# for pdf2htmlEX Wed 20 Nov 2013 12:22:31 EST
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"
