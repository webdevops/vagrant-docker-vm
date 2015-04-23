# Docker
alias dexec='docker exec -it'
alias docker-clean='docker rmi -f $(docker images | grep "<none>" | awk "{print \$3}")'
alias dcshell='ct docker:shell'
alias dcli='ct docker:cli'
alias dcsql='ct docker:mysql'
alias dcmysql='ct docker:mysql'

# show server headers
alias wgets='wget --spider --server-response'

# show my internet ip
alias myip="curl http://ipecho.net/plain; echo"

# less defaults
alias less='less -FSRX'

# workaround cd..
alias cd..='cd ..'

# alias for ack
alias ack='ack-grep'
alias todos="ack-grep --nogroup '(TODO|FIX(ME)?):'"

# find biggest files
alias diskspace="du -S | sort -n -r |less"

# color grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# start bc with mathlib
alias bc='bc -l'

# generate sha1 digest
alias sha1='openssl sha1'

# pretty mount
alias mount='mount |column -t'

# get current unixtime
alias unixtime='date +"%s"'

# show all open ports
alias ports='netstat -tulanp'

# get web server headers #
alias header='curl -I'

# find out if remote server supports gzip / mod_deflate or not #
alias headerc='curl -I --compress'

# reboot / halt / poweroff
alias reboot='echo [ERROR] Reboot this machine with vagrant!'
alias poweroff='sudo /sbin/poweroff'
alias halt='sudo /sbin/shutdown -h now'
alias shutdown='sudo /sbin/shutdown'

# auto sudo
alias apt-get='sudo apt-get'
alias htop='sudo htop'
alias iotop='sudo iotop'
alias iftop='sudo iftop'
alias service='sudo service'
alias strace='sudo strace'
alias netstat='sudo netstat'

# Git related
alias gs='git status'
alias gc='git commit'
alias ga='git add'
alias gd='git diff'
