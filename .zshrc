export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

fastfetch --logo-color-1 blue --logo-color-2 blue --color blue --title-color-at green --separator-output-color green -s title:separator:os:kernel:uptime:packages:terminal:cpu:cpuUsage:memory:gpu:disk:custom:colors
