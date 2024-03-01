autoload -Uz vcs_info
precmd() { vcs_info }

source ~/antigen.zsh
antigen bundle zsh-users/zsh-autosuggestions
antigen apply

zstyle ':vcs_info:git:*' formats '%b '
alias config="cd ~/.config && lsd"
alias server="sh ~/scripts/server-sshfs.sh" 
alias cls="clear && ls"
alias serverssh="ssh thesun@192.168.1.170"
setopt PROMPT_SUBST
alias dnf="sudo dnf"
alias init.lua="nvim ~/.config/nvim/init.lua"
alias ls="lsd"
alias ,="nvim"
alias .="sudo pacman -S"
alias dots="sh ~/scripts/dotfiles.sh" 
alias irc="irssi"
alias cp="cp -r"
alias steamos="steam -steamos3 -steamdeck -gamepadui"
alias acm0="sudo chmod a+rw /dev/ttyACM0"
alias p="sudo pacman"
alias n="nvim"
alias N="sudo nvim"
alias dc="cd .."
alias fetch="nitch"
alias unfuck_keyboard="setxkbmap -layout it"
alias unfuck_wifi="sudo systemctl restart networkmanager"

PROMPT='> '

EDITOR=nvim
# tmux
eval "$(starship init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
