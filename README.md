![welcome to arch4devs](https://i.imgur.com/z5MxNfc.png)

## Arch Linux working environment for developers

The best operating system for developers. Program in fast motion with this working environment 🚀.

![arch4devs screenshot](https://i.imgur.com/Haq6Vhe.png)

**Default shortcuts**
>
> * ```Super+Enter``` Open terminal (default = wezterm)
> * ```Super+Space``` Open the launcher
> * ```Super+q``` Kill focussed window
> * ```Super+0-9``` Switch to workspace
> * ```Super+v``` Open the clipboard history
> * ```Super+e``` Open the emoji picker
> * ```Print``` Takes a screenshot of the selected area
> * ```Shift+Print``` Takes a screenshot of the selected monitor
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

### 📁 Install

* Perform a **clean installation** of Arch Linux using **`archinstall`** with the Hyprland desktop environment.

* **Clone this repo and run the `install.sh` script:**
~~~bash
git clone https://github.com/SoyAlejandroCalixto/arch4devs ~/arch4devs && cd ~/arch4devs
./install.sh
~~~
> *Once the installation is finished, you can delete the ```~/arch4devs``` directory.*

Then restart and **that is all**. However, you may need to make some additional adjustments for your special conditions:

<details>
<summary>Change wallpaper</summary>

Go to ```~/.config/hypr/hyprpaper.conf``` and replace the paths of ```preload``` and ```wallpaper```:
~~~
preload = /your/wallpaper/path
wallpaper = , /your/wallpaper/path
~~~
</details>

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
<summary>Change key binds</summary>

Go to ```~/.config/hypr/binds.conf``` and follows the structure of the other key binds in the file:
~~~
bind = SUPER SHIFT, K, exec, any-command
~~~
</details>

<details>
<summary>Make the top bar appear on all monitors</summary>

Edit ```~/.config/eww/eww.yuck``` and check this part:
~~~
(defwindow topbar0
  :monitor 0
  :geometry (geometry :x "0%" :y "0%" :width "100%" :height "28px" :anchor "top center")
  :stacking "fg"
  :reserve (struts :distance "28px" :side "top")
  :windowtype "dock"
  :wm-ignore false
  (topbar))
~~~
Duplicate that block of code below and change ```topbar0``` to ```topbar1``` and ```:monitor 0``` to ```:monitor 1```.

Now edit ```~/.config/hypr/autostart.conf``` and add ```&& eww open topbar1``` to this line so that it opens at startup next to the other one:
~~~
exec-once = eww daemon && eww open topbar0 && eww open topbar1
~~~
Repeat this process with as many screens as you want.
</details>
