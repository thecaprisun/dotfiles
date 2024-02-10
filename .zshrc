autoload -Uz vcs_info
precmd() { vcs_info }

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

PROMPT='%/> '

EDITOR=nvim

eval "$(starship init zsh)"
