# General aliases
alias actapt='sudo apt-get -y update && sudo apt -y update'
alias upgapt='sudo apt -y upgrade'
alias greetings="echo 'Hola Ing. Rivas, gran master de linux, pro-robotics chief and witch doctor'"

alias rsttrm='exec "$SHELL"'
## alias path='echo -e ${PATH//:/\\n}'
alias path='sed "s/:/\n/g" <<< "$PATH" | sort | uniq'

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

# Mover despues
alias srcthis='source install/setup.bash'

