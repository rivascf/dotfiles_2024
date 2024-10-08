# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

##################################################################
## Adding configurations and code to replace default prompt     ##
## with My Awsome Prompt.                                       ##
##################################################################

enchulame_el_ps1=yes

###################################################################
## Validate git-prompt, venv-prompt and, ros-mgmt scripts exists ##
###################################################################

if [ -f ~/.config/gitbash/git-prompt.sh ]; then
	export GIT_PS1_SHOWDIRTYSTATE=true
	export GIT_PS1_SHOWSTASHSTATE=true
	export GIT_PS1_SHOWUNTRACKEDFILES=true
	# ?? export GIT_PS1_SHOWUPSTREAM="auto"
	# ?? export GIT_PS1_DESCRIBE_STYLE='branch'
	# ?? export GIT_PS1_SHOWCOLORHINTS=true
	. ~/.config/gitbash/git-prompt.sh
else
	enchulame_el_ps1=no
fi

if [ -f ~/.config/rosmgmt/ros_mgmt.sh ]; then
	. ~/.config/rosmgmt/ros_mgmt.sh
else
	enchulame_el_ps1=no
fi

if [ -f ~/.config/utilities/venv_prompt.sh ]; then
	. ~/.config/utilities/venv_prompt.sh
else
	enchulame_el_ps1=no
fi

if [ "$color_prompt" = yes ] || [ "$TERM" = "alacritty" ]; then
# Test to use enhanced prompt
    if [ enchulame_el_ps1 = no ]; then
	# Use default color prompt
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    else
	# New enhanced prompt adding venv_prompt, git-prompt and, ros_prompt 
	PS1='\[\e[0;1;34m\]╭─╼\[\e[0;1;34m\][\[\e[0;34m\]\u\[\e[0;1;38;5;31m\]@\[\e[0;36m\]\H\[\e[0;1;34m\]]\[\e[0;1;94m\]╾─╼\[\e[0;1;94m\][\[\e[0;37m\]\w\[\e[0;1;94m\]]\[\e[0m\]$(__venv_ps1 "\[\e[0;1;35m\]╾─╼[\[\e[0m\]%s\[\e[0;1;35m\]]\[\e[0m\]")\[\e[0m\]$(__git_ps1 "\[\e[0;1;32m\]╾─╼[\[\e[0m\] %s\[\e[0;1;32m\]]\[\e[0m\]")\n\[\e[0;1;36m\]╰─╼\[\e[0m\]$(__ros_ps1 "\[\e[0;36m\][\[\e[0m\]%s\[\e[0;36m\]]") \[\e[0m\]\$ \[\e[0m\]'
        ############
        ## Test TMux
        ############i
        # if [ "$TERM" = "screen" ] && [ "$TMUX" ]; then
	#    PS1='\[\e[0;1;34m\]╭─╼\[\e[0;1;34m\][\[\e[0;34m\]\u\[\e[0;1;38;5;31m\]@\[\e[0;36m\]\H\[\e[0;1;34m\]]\[\e[0;1;94m\]╾─╼\[\e[0;1;94m\][\[\e[0;37m\]\w\[\e[0;1;94m\]]\[\e[0m\]$(__venv_ps1 "\[\e[0;1;35m\]╾─╼[\[\e[0m\]%s\[\e[0;1;35m\]]\[\e[0m\]")\[\e[0m\]$(__git_ps1 "\[\e[0;1;32m\]╾─╼[\[\e[0m\] %s\[\e[0;1;32m\]]\[\e[0m\]")\n\[\e[0;1;36m\]╰─╼\[\e[0m\]$(__ros_ps1 "\[\e[0;36m\][\[\e[0m\]%s\[\e[0;36m\]]") \[\e[0m\](tmux)\$ \[\e[0m\]'
	    # PS1="(tmux) $PS1"
	# fi
    fi
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

######################################
## Promp including TMux (if is set) ##
######################################

if [ "$TERM" = "screen" ] && [ "$TMUX" ]; then
    #PS1='\[\e[0;1;34m\]╭─╼\[\e[0;1;34m\][\[\e[0;34m\]\u\[\e[0;1;38;5;31m\]@\[\e[0;36m\]\H\[\e[0;1;34m\]]\[\e[0;1;94m\]╾─╼\[\e[0;1;94m\][\[\e[0;37m\]\w\[\e[0;1;94m\]]\[\e[0m\]$(__venv_ps1 "\[\e[0;1;35m\]╾─╼[\[\e[0m\]%s\[\e[0;1;35m\]]\[\e[0m\]")\[\e[0m\]$(__git_ps1 "\[\e[0;1;32m\]╾─╼[\[\e[0m\] %s\[\e[0;1;32m\]]\[\e[0m\]")\n\[\e[0;1;36m\]╰─╼\[\e[0m\]$(__ros_ps1 "\[\e[0;36m\][\[\e[0m\]%s\[\e[0;36m\]]") \[\e[0m\](tmux)\$ \[\e[0m\]'

    PS1='\[\e[0;1;34m\]╭─╼\[\e[0;1;34m\][\[\e[0;34m\]\u\[\e[0;1;38;5;31m\]@\[\e[0;36m\]\H\[\e[0;1;34m\]]\[\e[0;1;94m\]╾─╼\[\e[0;1;94m\][\[\e[0;37m\]\w\[\e[0;1;94m\]]\[\e[0m\]$(__venv_ps1 "\[\e[0;1;35m\]╾─╼[\[\e[0m\]%s\[\e[0;1;35m\]]\[\e[0m\]")\[\e[0m\]$(__git_ps1 "\[\e[0;1;32m\]╾─╼[\[\e[0m\] %s\[\e[0;1;32m\]]\[\e[0m\]")\n\[\e[0;1;36m\]╰─╼\[\e[0m\]$(__ros_ps1 "\[\e[0;36m\][\[\e[0m\]%s\[\e[0;36m\]]") \[\e[0;96m\](tmux)\[\e[0m\]\$ \[\e[0m\]'
fi

# clean auxiliary variables
unset color_prompt force_color_prompt
unset enchulame_el_ps1

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    # Next line commented line to use 'lsd' instead default 'ls' command
    #alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Next aliases are commented to implement lsd functiotality 
# some more ls aliases
#alias ll='ls -alF'
#alias la='ls -A'
#alias l='ls -CF'

# LSD declaration and aliases

alias ls='lsd'
alias  l='ls -l'
alias la='ls -a'
alias ll='ls -la'
alias lt='ls --tree'


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


##################################
## RUST compiler configuration  ##
##################################

. "$HOME/.cargo/env"

#########################################################################################################################
# To solve PIP, PIP3													#
#     WARNING: The scripts pip, pip3 and pip3.8 are installed in '/home/tsruser/.local/bin' which is not on PATH.	#
#     Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location. #
#     set PATH so it includes user's private bin if it exists								#
#########################################################################################################################
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi


#####################
## IP information  ##
#####################

iptype=$(ip address show | grep '2: ' | awk -F': ' '{print $2}')
if [ -z $iptype ]; then
    ip='127.0.0.1'
    iptype='loopback'
else
   ip=$(ip addr show $iptype 2>/dev/null | grep -o 'inet [0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+' | grep -o [0-9].*)
fi

# iptype='ethernet'
# if [ -z $ip ]; then
#  ip=$(ip addr show wlan0 | grep -o 'inet [0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+' | grep -o [0-9].*)
#  iptype='wifi'
#  if [ -z $ip ]; then
#    ip=$(ip addr show ens33 | grep -o 'inet [0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+' | grep -o [0-9].*)
#    iptype='unknown interface'
#  else
#    ip='127.0.0.1'
#    iptype='loopback'
#  fi
#fi 

export IP=$ip
export IPTYPE=$iptype
unset ip
unset iptype

##########################
## PyEnv configuration  ##
##########################
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
# Disable default venv prompt to show it in  my own theme.
export VIRTUAL_ENV_DISABLE_PROMPT=true


###############################################
## Node Version Manager (NVM) configuration  ##
###############################################
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


################################
## ROS2 configuration script  ##
################################
if [ -f ~/.config/rosmgmt/ros2_humble_conf.bash ]; then
    . ~/.config/rosmgmt/ros2_humble_conf.bash
fi
