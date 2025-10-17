# If you come from bash you might have to change your $PATH.
#export PATH=$HOME/.local/bin:$PATH

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

#zstyle ':omz:update' mode auto
zstyle ':omz:*' aliases no

source $ZSH/oh-my-zsh.sh

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nano'
else
  export EDITOR='nano'
fi

cd() { builtin cd "$@"; ls -lah --color=auto; }

alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../..'
alias f='open ./'
alias desktop='cd ~/Desktop'
alias iperf='iperf3 -i .5 -t 5 -c'
alias l='ls -lah --color=auto'
alias ls='ls -lah --color=auto'
alias indigostop='killall indigo_server'
alias nvme='sudo smartctl -a /dev/nvme0 | grep "Temperature:"'
alias path='echo -e ${PATH//:/\\n}'
alias ping='ping -i .5'
alias rc='sudo nano /etc/rc.local'
alias reboot='sudo reboot'
alias shutdown='sudo shutdown now'
alias trim='sudo fstrim -av'
alias ulb='cd /usr/local/bin'
alias update='sudo apt update && sudo apt -y full-upgrade'
alias yes='yes > /dev/null &'
alias yes4='yes yes yes yes'
alias yess='killall yes'
alias zrc='nano ~/.zshrc && exec zsh'
alias 4k='xrandr -s 1920x1080'
alias 2k='xrandr -s 1440x900'
