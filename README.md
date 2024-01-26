![arch4devs](https://github.com/SoyAlejandroCalixto/arch4devs/assets/97924741/1f3a8d30-c0eb-472a-9637-ec241b383d61)

## Arch Linux working environment for developers

The best operating system for developers. Program in fast motion with this working environment 🚀.

![arch4devs screenshot](https://github.com/SoyAlejandroCalixto/arch4devs/assets/97924741/dd3aba29-59d5-4c2d-a334-5e3cf40ee08b)

**Note:** If you already have an Arch Linux installation with any other desktop environment than QTile, this installation will not conflict with your current Arch, i.e. nothing will happen to your original installation and you can have this working environment completely parallel to your regular Arch without compromising your current operating system.

~ **Default shortcuts**

* ```Ctrl+Super+B``` open Brave browser
* ```Ctrl+Super+D``` open Discord
* ```Ctrl+Super+C``` open VSCode
* ```Super+Enter``` open terminal
* ```Super+Space``` open applications menu
* ```Super+Number``` change workspace
* ```Print``` take a screenshot
* ```Super+E``` emoji picker
* ```Ctrl+Space``` focus on the next window
* ```Super+drag window``` turn on the floating window and move/resize it with the left and right click
* ```Super+T``` turn on/off the floating window for the window you have in focus at the moment
* ```Super+F``` turn on/off fullscreen for the window you have in focus at the moment
* ```Super+W``` closes the window in focus
* ```Super+O/P``` Volume down/up (it can also be done from the polybar)
* ```Super+Ctrl+Q``` Shutdown

### 🗁 Install guide

~ **Prerequisites:**
* **[Arch Linux](https://wiki.archlinux.org/title/Installation_guide)** (actually you can install it on any Linux distro, but it is focused and tested on Arch)
* **An AUR helper** (yay, paru...)

~ **Install the necessary packages:**
~~~
sudo pacman -S --noconfirm --needed qtile alsa-utils polybar polkit-gnome rofi flameshot zsh gnome-characters nautilus kitty gnome-system-monitor discord unzip

yay -S --noconfirm --needed brave-bin visual-studio-code-bin pamac-all spotify

chsh -s /bin/zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
~~~

~ **Extract the ```arch4devs``` folder in your ```/home/<user>``` directory**

![nautilus extracting arch4devs](https://github.com/SoyAlejandroCalixto/arch4devs/assets/97924741/426706b6-b829-4986-9890-753a75249b1f)

by terminal: ```unzip ~/arch4devs.zip```

~ Then, **restart your computer** and in your display manager **change the session to ```QTile```** and log in.

![image](https://github.com/SoyAlejandroCalixto/arch4devs/assets/97924741/e8abd385-ce3a-4ab3-a990-5891678c15be)

If you are an average user, this guide is over for you, but if you meet any of the following exceptions, you will need to do some additional steps.

<details>
<summary>Do you have more than one screen?</summary>
  
If you have a second screen, you must modify these 3 files:

Go to ```~/.config/qtile/autostart.sh``` and replace the text there with the following:
~~~
#!/bin/sh
polybar leftbar &
polybar rightbar &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
~~~

Go to ```~/.config/qtile/config.py``` and replace the Python list named ```screens``` with this one:
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
and in the ```monitor``` property change ```HDMI-1``` by the connector that you have, i.e. if you use **Display Port** you should put ```DP-1```, if you use DVI-D you should put ```DVI-D-1```, and if you use HDMI you can leave it as it is in ```HDMI-1```.

**Restart the computer.**
</details>

<details>
<summary>Do you speak a language other than English?</summary>

To change the language of certain elements that polybar has, go to ```~/.config/polybar/config.ini``` and look where it says:
~~~
[bar/leftbar]
# locale = es_ES.UTF-8
~~~

uncomment the line with the ```#``` and put the value you want, for example, ```es_ES.utf-8``` would set the language to Spanish.

**Restart the computer.**
</details>
