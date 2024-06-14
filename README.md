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
* ```Alt+Space``` focus on the next window
* ```Super+I/J/K/L``` resizes the window that is in focus
* ```Ctrl+Super+I/J/K/L``` moves the window that is in focus
* ```Super+Alt+1-9``` Moves the window in focus to the specified workspace
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
sudo pacman -S --noconfirm --needed qtile alsa-utils polybar polkit-gnome rofi fastfetch xclip flameshot picom zsh gnome-characters nemo wezterm gnome-system-monitor discord dunst fontconfig unzip lsd bat

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

That is all. However, there are things that can be changed according to the user's preferences, and many of these most frequent cases will be explained below.

### 🪄 Customization

<details>
<summary>I have multiple screens, how do I configure them?</summary>

Go to ```~/.config/qtile/modules/visual.py``` and add to the Python list named ```screens``` as many ```screen()``` objects as you have screens, for example, if you have 2 monitors:
~~~
screens = [
    Screen(
        wallpaper='~/.local/share/backgrounds/my_wallpaper.png',
        wallpaper_mode='stretch',
    ),
    Screen(
        wallpaper='~/.local/share/backgrounds/my_wallpaper.png',
        wallpaper_mode='stretch',
    ),
]
~~~

Then go to ```~/.config/polybar/config.ini``` and look for the part that says:
~~~
[bar/rightbar]
monitor = HDMI-1
...
~~~
and in the ```monitor``` property change ```HDMI-1``` to the display where you want to put this second polybar *(if you only want to have a single polybar, ignore all this)*, to see the list of displays you have, install the ```xorg-xrandr``` package and run the ```xrandr``` command to see a list.

> **Note:** You can create as many polybars as you want for as many monitors as you want, you only have to copy and paste the code of the ```[bar/rightbar]``` as many times as you want, but changing the name ```rightbar``` to avoid duplicity problems, and changing the ```monitor``` property to the desired display.

And finally go to your autostart script, located in ```~/.config/qtile/autostart.sh``` and add ```polybar rightbar &``` to auto-initialize that polybar at login.
~~~
#!/bin/sh
picom &
polybar leftbar &
polybar rightbar &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
~~~

**Restart the computer.**

In addition, if you want to change the **main monitor**, install the ```xorg-xrandr``` package and add this line as the first command in your autostart script, located in ```~/.config/qtile/autostart.sh```:
~~~
#!/bin/sh
xrandr --output HDMI-1 --primary &
...
~~~
Changing ```HDMI-1``` to the display you want to set as the main display. Then **restart your computer.**
</details>

<details>
<summary>I don't speak English, how do I set the polybar language?</summary>

To change the language of certain elements that polybar has, go to ```~/.config/polybar/config.ini``` and look where it says:
~~~
[bar/<any bar>]
# locale = es_ES.UTF-8
~~~

uncomment the line with the ```#``` and put the value you want, for example, ```es_ES.utf-8``` would set the language to Spanish.

**Restart the computer.**
</details>

<details>
<summary>How do I change the wallpaper?</summary>

Go to ```~/.config/qtile/modules/visual.py``` and look at the Python list called ```screens```:
~~~
screens = [
    Screen(
        wallpaper='~/.local/share/backgrounds/7.png',
        wallpaper_mode='stretch',
    )
]
~~~
This list has one or more ```Screen()``` objects, whose first parameter is ```wallpaper```, change the path to the path of your desired wallpaper, and **restart the computer**.
</details>

<details>
<summary>How do I change the mouse speed?</summary>

install the ```xorg-xinput``` package, and run the ```xinput list``` command to see a list of connected devices along with their ID, and remember the ID of your mouse.

Assuming your mouse has ID ```12```, run ```xinput --list-props 12``` to see the list of properties that your mouse has.

Among all the results it gives you, look for the name of the property that could set the mouse speed. In my case it is ```libinput Accel Speed```, however in your case it could change.

Knowing this, run the command:
~~~
xinput --set-prop <your-mouse-id> 'libinput Accel Speed' <a number between -1 and 1>
~~~

To prevent this from being reset to its default value every time you restart the computer, add the command to your autostart script located at ```~/.config/qtile/autostart.sh```:
~~~
#!/bin/sh
xinput --set-prop 12 'libinput Accel Speed' -0.5 &
...
~~~
</details>

<details>
<summary>I want to change the key binds to put the ones I want.</summary>

Go to ```~/.config/qtile/modules/binds.py```:
~~~
keys_binds = [
    ...
    # spawn apps
    Key([super, alt], "b", lazy.spawn('brave')),
    Key([super, alt], "c", lazy.spawn('code')),
    Key([super, alt], "d", lazy.spawn('discord')),
    Key([super], "Return", lazy.spawn(default_terminal)),
    ...
]
~~~
Here you will find all current key binds. Modify, delete or add as many as you want in that file, and then **restart the computer** for the changes to take effect. The ```lazy.spawn("command")``` function executes a command.
</details>

<details>
<summary>I want to change the cursor theme, how do I do it?</summary>

First, download the theme of your choice, for example, I am going to install the ```Bibata-Modern-Classic``` theme from [here](https://www.pling.com/p/1914825).

If you want to set this cursor for your entire OS, paste the theme folder in ```/usr/share/icons/```.

The only thing left to do now is to set the theme as default. In case you have installed the theme for your entire OS, you must edit the file ```/usr/share/icons/default/index.theme```, and put the following content:

~~~
[Icon Theme]
Inherits=Bibata-Modern-Classic
~~~

The next time you **restart your computer** you will have that cursor set.



</details>
