![welcome to arch4devs](https://github.com/SoyAlejandroCalixto/arch4devs/assets/97924741/ea0fd3db-20ac-49f0-877d-43026d058139)

## Arch Linux working environment for developers

The best operating system for developers. Program in fast motion with this working environment 🚀.

![arch4devs screenshot](https://github.com/SoyAlejandroCalixto/arch4devs/assets/97924741/32159b60-efe6-4dad-b53b-ff605b58dfdb)


**Note:** If you already have an Arch Linux installation with any other desktop environment than QTile, this installation will not conflict with your current Arch, i.e. nothing will happen to your original installation and you can have this working environment completely parallel to your regular Arch without compromising your current operating system.

~ **Default shortcuts**

* ```Super+Alt+B``` open Brave browser
* ```Super+Alt+D``` open Discord
* ```Super+Alt+C``` open VSCode
* ```Super+Enter``` open terminal
* ```Super+Space``` open applications menu
* ```Super+1-9``` change workspace
* ```Print``` take a screenshot
* ```Super+E``` emoji picker
* ```Ctrl+Space``` focus on the next window
* ```Super+I/J/K/L``` resizes the window that is in focus
* ```Ctrl+Super+I/J/K/L``` moves the window that is in focus
* ```Super+drag window``` turn on the floating window and move/resize it with Super + left/right click
* ```Super+T``` turn on/off the floating window for the window you have in focus at the moment
* ```Super+F``` turn on/off fullscreen for the window you have in focus at the moment
* ```Super+W``` closes the window in focus
* ```Super+O/P``` Volume down/up (it can also be done from the polybar)

### 🗁 Install guide

~ **Prerequisites:**
* **[Arch Linux](https://wiki.archlinux.org/title/Installation_guide)** (actually you can install it on any Linux distro, but it is focused and tested on Arch)
* **An AUR helper** (yay, paru...)

~ **Install the necessary packages:**
~~~
sudo pacman -S --noconfirm --needed qtile alsa-utils polybar polkit-gnome rofi flameshot picom zsh gnome-characters nemo kitty gnome-system-monitor discord fontconfig unzip lsd bat

yay -S --noconfirm --needed brave-bin visual-studio-code-bin pamac-all spotify

chsh -s /bin/zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
~~~

~ **Clone the arch4devs repository**
~~~
git clone https://github.com/SoyAlejandroCalixto/arch4devs.git
~~~
And put all its contents in your ```/home/<user>``` folder *(except the readme, the license and the .gitignore)*

~ Then, **restart your computer** and in your display manager **change the session to ```QTile```** and log in.

![image](https://github.com/SoyAlejandroCalixto/arch4devs/assets/97924741/e8abd385-ce3a-4ab3-a990-5891678c15be)

If you are an average user, this guide is over for you, but if you meet any of the following exceptions, you will need to do some additional steps.

<details>
<summary>Do you have more than one screen?</summary>
  
If you have more than one screen, you must modify these 3 files:

Go to ```~/.config/qtile/autostart.sh``` and add ```polybar rightbar &``` if you want to load another polybar on another monitor and not just one:
~~~
#!/bin/sh
picom &
polybar leftbar &
polybar rightbar &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
~~~

*(you can also create as many polybars as you want for all your monitors if you wish)*

Now go to ```~/.config/qtile/modules/visual.py``` and add to the Python list named ```screens``` as many ```screen()`` as you have screens, for example, if you have 2 monitors:
~~~
screens = [
    Screen(
        wallpaper='~/.local/share/backgrounds/2023-12-01-09-08-12-2023-10-23-21-38-20-image (4).png',
        wallpaper_mode='stretch',
    ),
    Screen(
        wallpaper='~/.local/share/backgrounds/2023-12-01-09-08-12-2023-10-23-21-38-20-image (4).png',
        wallpaper_mode='stretch',
    ),
]
~~~

Go to ```~/.config/polybar/config.ini``` and look for the part that says:
~~~
[bar/rightbar]
monitor = HDMI-1
~~~
and in the ```monitor``` property change ```HDMI-1``` to the connector you have on the monitor where you want to put this second polybar (if you only want to have a single polybar, ignore this), i.e. if you use **Display Port** you should put ```DP-1```, if you use DVI-D you should put ```DVI-D-1```, and if you use HDMI you can leave it as it is in ```HDMI-1```.

If you want to change the **main monitor**, install the package ```xorg-xrandr``` and add this line as the first command in your ```~/.config/qtile/autostart.sh```:
~~~
#!/bin/sh
xrandr --output HDMI-1 --primary &
...
~~~

**Restart the computer.**
</details>

<details>
<summary>Do you speak a language other than English?</summary>

To change the language of certain elements that polybar has, go to ```~/.config/polybar/config.ini``` and look where it says:
~~~
[bar/<any bar>]
# locale = es_ES.UTF-8
~~~

uncomment the line with the ```#``` and put the value you want, for example, ```es_ES.utf-8``` would set the language to Spanish.

**Restart the computer.**
</details>
