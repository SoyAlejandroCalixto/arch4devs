![welcome to arch4devs](https://i.imgur.com/jkrusw8.png)

## Arch Linux working environment for developers

The best operating system for developers. Program in fast motion with this working environment 🚀.

![arch4devs screenshot](https://i.imgur.com/J7XCmLB.png)

**Note:** If you already have an Arch Linux installation with any other desktop environment than Hyprland, this installation will not conflict with your current Arch, i.e. you can have this working environment in parallel without compromising your current operating system.

**Default shortcuts**
>
> * ```Super+Enter``` Open terminal (default = wezterm)
> * ```Super+Space``` Open the laucher
> * ```Super+q``` Kill focussed window
> * ```Super+0-9``` Switch to workspace
> * ```Super+v``` Open the clipboard history
> * ```Print``` Takes a screenshot of the selected area
> * ```Shift+Print``` Takes a screenshot of the selected monitor
> * ```Super+-/+``` Volume down/up (it can also be done from the polybar slider)
> * ```Super+←/↑/→/↓``` Move the workspace to the left/right monitor
> * ```Super+Ctrl+←/↑/→/↓``` Resize focussed window (it can also be done with right click + drag)
> * ```Super+Alt+←/↑/→/↓``` Move focussed window (it can also be done with left click + drag)
> * ```Super+Shift+←/↑/→/↓``` Move the focus to another window
> * ```Super+Shift+b``` Open the browser (default = brave)
> * ```Super+Shift+e``` Open the file manager (default = ranger)
> * ```Super+Shift+c``` Open the code editor (default = neovim)
> * ```Super+f``` Toggle floating window
> * ```Super+p``` Toggle pseudo window
> * ```Super+s``` Toggle vertical/horizontal split (2 or more windows)

### 🗁 Install guide

**Prerequisites:**
* **[Arch Linux](https://wiki.archlinux.org/title/Installation_guide)** (actually you can install it on any Linux distro, but it is focussed and tested on Arch)
* **An AUR helper** (yay, paru...)

**Install the necessary packages:**
~~~
sudo pacman -S --noconfirm --needed hyprland hyprpaper zsh alsa-utils vlc waybar polkit-kde-agent xdg-desktop-portal-hyprland xdg-desktop-portal-gtk gnome-themes-extra fastfetch wl-clipboard wtype ranger wezterm discord dunst fontconfig zip unzip p7zip lsd bat

paru -S --noconfirm --needed brave-bin ulauncher clipse hyprshot spotify visual-studio-code-bin adwaita-qt5-git adwaita-qt6-git

chsh -s /bin/zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
~~~

**Clone the arch4devs repository**
~~~
git clone https://github.com/SoyAlejandroCalixto/arch4devs.git
~~~
And put all its contents in your ```/home/<user>``` folder *(except the readme, the license and the .gitignore)*

Then, **restart your computer** and in your display manager **change the session to ```Hyprland```** and log in.

![image](https://i.imgur.com/I2tAl2K.png)

That is all. However, there are some additional adjustments you could make:

<details>
<summary>Configure multiple screens</summary>

Run ```hyprctl monitors all``` and check the name of your monitors, for example, if you have a monitor connected by HDMI, it is probably called ```HDMI-1```.

Go to ```~/.config/hypr/monitors.conf```, delete the auto config and replace it with this format: ```name,resolution,position,scale```

For example, if you have two monitors with the names ```HDMI-1``` and ```DP-1```, this would be a standard configuration:
~~~
monitor=HDMI-1,1920x1080@75,0x0,1
monitor=DP-1,1920x1080@60,1920x0,1
~~~
</details>

<details>
<summary>Change wallpaper</summary>

Go to ```~/.config/hypr/hyprpaper.conf``` and replace the paths of ```preload``` and ```wallpaper```:
~~~
preload = /your/wallpaper/path
wallpaper = , /your/wallpaper/path
~~~
</details>

<details>
<summary>Change key binds</summary>

Go to ```~/.config/hypr/binds.conf``` and follows the structure of the other key binds in the file:
~~~
bind = SUPER SHIFT, K, exec, any-command
~~~
</details>
