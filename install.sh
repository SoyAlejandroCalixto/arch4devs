if [ ! -e "$HOME/arch4devs" ]; then # Check if 'arch4devs' was cloned in the correct path
    echo -e "\e[31mError: '~/arch4devs' directory not found. The installation cannot proceed.\e[0m"
else
    sudo -v # make sudo never ask me for a password
    while true; do sudo -n true; sleep 60; done 2>/dev/null &
    SUDO_PID=$!

    if ! command -v paru &> /dev/null; then
        echo -e "\e[34mParu is not installed, installing...\e[0m"
        git clone https://aur.archlinux.org/paru-git.git ~/paru-git
        cd ~/paru-git
        makepkg -si
        cd ~/
        sudo rm -rf ~/paru-git
    fi

    echo -e "\e[34mInstalling necessary packages...\e[0m"
    sudo pacman -Syu --noconfirm --needed
    sudo pacman -S --noconfirm --needed git github-cli neovim hyprland hyprpaper lua lua-lgi playerctl socat zsh noto-fonts-emoji adobe-source-han-sans-jp-fonts ttf-cascadia-code-nerd vlc eog polkit-kde-agent xdg-desktop-portal-hyprland xdg-desktop-portal-gtk gnome-themes-extra fastfetch wl-clipboard wtype ranger ripgrep zoxide atuin wezterm discord dunst fontconfig zip unzip p7zip lsd bat
    paru -S --noconfirm --needed brave-bin eww rofi-wayland rofimoji clipton hyprshot spotify adwaita-qt5-git adwaita-qt6-git

    mkdir -p ~/.local/share/fonts # -> Fonts that do not exist as a package
    git clone https://github.com/simpals/onest.git /tmp/onest
    mv /tmp/onest/fonts/ttf/*.ttf "$HOME/.local/share/fonts/"
    rm -rf /tmp/onest

    echo -e "\e[34mInstalling shell stuff...\e[0m"
    chsh -s /bin/zsh
    export RUNZSH=no && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/hlissner/zsh-autopair ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autopair

    echo -e "\e[34mInstalling arch4devs...\e[0m"
    cp -r ~/arch4devs/. ~/
    sudo rm -rf ~/.git && sudo rm -rf ~/README.md && sudo rm -rf ~/install.sh && sudo rm -rf ~/LICENSE && sudo rm -rf ~/.gitignore # Clean repo trash

    echo -e "\e[32mFinished. Restart your computer with 'reboot' command.\e[0m\n"

    trap "kill $SUDO_PID 2>/dev/null" EXIT # kill the process that keeps sudo without password
fi
