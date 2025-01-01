export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-autopair)

source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

fastfetch --logo $HOME/.local/share/ascii/on_terminal_enter.txt --logo-color-1 cyan --logo-padding-right 2 --color green -s os:kernel:uptime:packages:cpuUsage:memory --key-type icon --separator "  "

alias vim=nvim
alias rcat=/usr/bin/cat
alias cat=bat
alias rls=/usr/bin/ls
alias ls=lsd
