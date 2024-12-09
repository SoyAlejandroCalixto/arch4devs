export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-autopair)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

fastfetch --logo $HOME/.icons/on_terminal_enter.webp --logo-type kitty-direct --logo-padding-right 1 --color blue -s os:kernel:uptime:packages:cpuUsage:memory

alias vim=nvim
alias rcat=/usr/bin/cat
alias cat=bat
alias rls=/usr/bin/ls
alias ls=lsd
