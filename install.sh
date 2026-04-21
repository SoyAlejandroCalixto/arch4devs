if [ ! -e "$HOME/arch4devs" ]; then  # Check if 'arch4devs' was cloned in the correct path
    echo -e "\e[31mError: '~/arch4devs' directory not found. The installation cannot proceed.\e[0m"
    exit 1
fi

sudo -v # Prevent sudo from asking for your password again
while true; do sudo -n true; sleep 60; done 2>/dev/null &
SUDO_PID=$!

sudo pacman -S --noconfirm --needed base-devel # Required for building AUR pkgs

if ! command -v paru &> /dev/null; then
    echo -e "\e[34mParu is not installed, installing...\e[0m"
    git clone https://aur.archlinux.org/paru.git ~/paru
    cd ~/paru
    makepkg -si
    cd ~/
    sudo rm -rf ~/paru
fi

echo -e "\e[34mInstalling necessary packages...\e[0m"
sudo pacman -Syu --needed --noconfirm reflector # Set the best mirror
sudo reflector --latest 10 --age 1 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

sudo pacman -Rns --noconfirm dolphin vim kitty wofi # Remove unused

sudo pacman -Syu --noconfirm --needed git github-cli neovim hyprland hyprpaper lua lua54 lua54-lgi playerctl socat zsh noto-fonts-emoji adobe-source-han-sans-jp-fonts ttf-cascadia-code-nerd vlc eog polkit-kde-agent xdg-desktop-portal-hyprland xdg-desktop-portal-gtk gnome-themes-extra fastfetch wl-clipboard wtype ranger nemo zoxide atuin wezterm discord dunst fontconfig zip unzip p7zip lsd bat fzf bitwarden
paru -S --noconfirm --needed brave-bin eww rofi-wayland rofimoji cliphist hyprshot pear-desktop update-grub cloudflare-warp-bin fnm

mkdir -p ~/.local/share/fonts # Install fonts that do not exist as a package
git clone https://github.com/simpals/onest.git /tmp/onest
mv /tmp/onest/fonts/ttf/*.ttf "$HOME/.local/share/fonts/"
rm -rf /tmp/onest

# Install kernel zen
sudo pacman -S --needed --noconfirm linux-zen linux-zen-headers
sudo update-grub

if lspci | grep -i "nvidia" &> /dev/null; then # If you have an NVIDIA GPU
    sudo pacman -S --needed --noconfirm nvidia-dkms nvidia-utils nvidia-settings opencl-nvidia cuda lib32-nvidia-utils vulkan-icd-loader egl-wayland
    sudo nvidia-xconfig

    KERNEL_MODULES="nvidia nvidia_modeset nvidia_uvm nvidia_drm"
    sudo sed -i "s/MODULES=()/MODULES=(${KERNEL_MODULES})/" /etc/mkinitcpio.conf

    echo "options nvidia_drm modeset=1 fbdev=1" | sudo tee /etc/modprobe.d/nvidia.conf &> /dev/null
    sudo mkinitcpio -P

    # Disable nouveau if you are using it
    if lsmod | grep nouveau &> /dev/null; then
        echo "blacklist nouveau" | sudo tee /etc/modprobe.d/nouveau.conf &> /dev/null
    fi
else # If you have an AMD GPU
    sudo pacman -S --noconfirm --needed linux-firmware mesa lib32-mesa opencl-mesa rocm-opencl-runtime vulkan-radeon lib32-vulkan-radeon amdvlk lib32-amdvlk
fi

# Shell stuff
chsh -s /bin/zsh
export RUNZSH=no && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/hlissner/zsh-autopair ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autopair

# Ranger config and plugins
mkdir -p $HOME/.config/ranger/plugins
git clone https://github.com/alexanderjeurissen/ranger_devicons $HOME/.config/ranger/plugins/ranger_devicons
echo "default_linemode devicons" >> $HOME/.config/ranger/rc.conf
git clone https://github.com/maximtrp/ranger-archives.git $HOME/.config/ranger/plugins/ranger-archives
echo "set preview_images true" >> $HOME/.config/ranger/rc.conf
echo "set preview_images_method iterm2" >> $HOME/.config/ranger/rc.conf

# Cloudflare Warp config
sudo systemctl enable warp-svc
sudo systemctl start warp-svc
warp-cli registration new

# Clone dotfiles
echo -e "\e[34mInstalling arch4devs...\e[0m"
cp -r ~/arch4devs/. ~/
sudo rm -rf ~/.git && sudo rm -rf ~/README.md && sudo rm -rf ~/install.sh && sudo rm -rf ~/LICENSE && sudo rm -rf ~/.gitignore # Clean repo trash

echo -e "\e[32mFinished. Restart your computer with 'reboot' command.\e[0m\n"

trap "kill $SUDO_PID 2>/dev/null" EXIT # kill the process that keeps sudo without password
