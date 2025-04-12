# General aliases
alias actapt='sudo apt-get -y update && sudo apt -y update'
alias upgapt='sudo apt -y upgrade'
alias cleanapt='sudo apt autoremove'

# Disk utils aliases
alias chkdsksp='df -h --total | grep /dev/sda | sort -rn '
alias largest='du --max-depth=1 2> /dev/null | sort -rn | head -n20'
# To resset terminal
alias rsttrm='exec "$SHELL"'
## alias path='echo -e ${PATH//:/\\n}'
alias path='sed "s/:/\n/g" <<< "$PATH" | sort | uniq'
# Show top 10 biggest subdirs in the current dir
# from: https://askubuntu.com/questions/5980/how-do-i-free-up-disk-space
alias ducks='du -cks * | sort -rn | head'

# Git aliases
alias   g='git'
alias gst='g status -sb'

# Python enviroments
alias initvenv='python -m venv .venv'
alias startvenv='source .venv/bin/activate'

# Change default vim for neovim
alias vim='nvim'

# Jupyter Notebook and Jupyter Lab aliases
alias jpn='jupyter notebook'
alias jpl='jupyter lab'

# Networking aliases
# Show open ports
alias ports='netstat -tulanp'
# Control output of networking tool called ping
# Stop after sending count ECHO_REQUEST packets #
alias ping='ping -c 5'
# Do not wait interval 1 second, go fast #
alias fastping='ping -c 100 -s 2'

# Mover despues al script de ROS
alias srcthis='source install/setup.bash'

# docker aliases
#  from: "How to delete cache?" - https://forums.docker.com/t/how-to-delete-cache/5753
alias docker_clean_images='docker rmi $(docker images -a --filter=dangling=true -q)'
alias docker_clean_ps='docker rm $(docker ps --filter=status=exited --filter=status=created -q)'

