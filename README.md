# My Debian 10 (Buster) Setup

This is my nimble computer setup - a very lightweight Debian 10.9 (Buster) installation with Openbox and cool tweaks.

It has been configured on a [Dell Inspiron 11 3000 (Pentium N3710 Quad-Core) laptop](https://www.ozbargain.com.au/node/324047).


## Busy
![Alt text](desktop-busy.png?raw=true "Desktop Busy")


## Clean
![Alt text](desktop-clean.png?raw=true "Desktop Clean")


## SLiM Login Preview
![Alt text](cuphead/preview.png?raw=true "SLiM Login Preview")


## Window Snapping Demo
![Alt text](window-snapping-demo.gif?raw=true "Window Snapping")


## Window Snapping Shortcuts

`Super Key (Win Key) + Up` - Resizes window to 100% width and 100% height

`Super Key (Win Key) + Right` - Snaps window to the right at 50% width and 100% height

`Super Key (Win Key) + Down` - Resizes window to 50% width and 50% height

`Super Key (Win Key) + Left` - Snaps window to the left at 50% width and 100% height

`Super Key (Win Key) + Alt + Up` - Snaps window to the top at 50% width and 50% height

`Super Key (Win Key) + Alt + Right` - Snaps window to the right at 50% width and 50% height

`Super Key (Win Key) + Alt + Bottom` - Snaps window to the bottom at 50% width and 50% height

`Super Key (Win Key) + Alt + Left` - Snaps window to the left at 50% width and 50% height

`Super Key (Win Key) + Alt + 1-8` - Window Tiling at 25% width and 50% height


## General Shortcuts

`Super Key (Win Key) + R` - Launches ROFI with application search

`Super Key (Win Key) + C` - Launches ROFI with clipboard history


## Install Debian Buster

Go to the [Debian downloads](https://www.debian.org/CD/netinst/) and grab the latest amd64 NetInstall.

Once downloaded, open up terminal and make a bootable USB:

```bash
sudo dd if=debian-10.9.0-amd64-netinst.iso of=/dev/sdb# bs=4M; sync
```


## Installing Network Tools and Drivers

Before proceeding any further, make sure you login as root.


### Install Drivers:

Clone the following repo:

```bash
git clone https://github.com/OpenELEC/iwlwifi-firmware.git
```

Create a firmware directory on your linux machine:

```bash
cd /lib/ && mkdir firmware
```

Copy all the contents of firmware from the Github repo and put it in `lib/firmware` on your linux machine.


### Install Wireless Tools

Download and copy the following packages onto a USB. Mount the USB and install the following packages:

- [libiw30](https://packages.debian.org/buster/amd64/libiw30/download)
- [libnl-3-200](https://packages.debian.org/buster/amd64/libnl-3-200/download)
- [libnl-genl-3-200](https://packages.debian.org/buster/amd64/libnl-genl-3-200/download)
- [libnl-route-3-200](https://packages.debian.org/buster/amd64/libnl-route-3-200/download)
- [libpcsclite1](https://packages.debian.org/buster/amd64/libpcsclite1/download)
- [wpa_supplicant](https://packages.debian.org/buster/amd64/wpasupplicant)
- [wireless-tools](https://packages.debian.org/buster/amd64/wireless-tools)


## Configure Network

```bash
nano /etc/network/interfaces
```

Replace the contents below `source /etc/network/interfaces.d/*` with:

```bash
auto wlp1s0
iface wlp1s0 inet dhcp
```


## Connect to Wireless

Create a new wpa_supplicant config:

`wpa_passphrase 'YOUR_NETWORK_NAME' NETWORK_PASSWORD >> /etc/network/interfaces`

Now edit `/etc/network/interfaces` to look like below (make sure to remove `network={...` and the other weird formatting:

```bash
auto wlp1s0
iface wlp1s0 inet dhcp
    wpa-ssid NETWORK_NAME_FROM_SSID_WITHOUT_QUOTES
    wpa-psk KEY_GENERATED_FROM_PSK
```

run the following commands:

```bash
ifup wlp1s0

dhclient wlp1s0
```

Try pinging google.com `ping google.com`. If it works, you're in business! :)


## Updating Sources

`nano /etc/apt/sources.list`

```bash
deb http://deb.debian.org/debian/ buster main contrib non-free
deb-src http://deb.debian.org/debian/ buster main contrib non-free

deb http://security.debian.org/debian-security buster/updates main contrib non-free
deb-src http://security.debian.org/debian-security buster/updates main contrib non-free

# buster-updates, previously known as 'volatile'
deb http://deb.debian.org/debian/ buster-updates main contrib non-free
deb-src http://deb.debian.org/debian/ buster-updates main contrib non-free
```

## Install Packages

Once you are connected to the internet, upgrade your system and install the packages below:
    
```bash
sudo apt update && sudo apt upgrade -y && \
sudo apt install aptitude apt-transport-https libnotify-bin xorg xbacklight \
openbox pulseaudio volumeicon-alsa obconf obmenu curl xclip p7zip htop \
rofi nitrogen tint2 nomacs xcompmgr zip thunar thunar-archive-plugin \
thunar-media-tags-plugin terminator lxappearance lxappearance-obconf \
git gitk autoconf libgtk-3-dev chromium wicd xscreensaver xscreensaver-gl-extra \
xscreensaver-data-extra simplescreenrecorder simple-scan gnome-disk-utility \
ack-grep vlc libssl1.1 gsimplecal arandr dunst gnome-screenshot arc-theme \
neofetch fonts-noto-color-emoji dnsutils slim \
binutils build-essential arc-theme moka-icon-theme -y
```

```bash
reboot
```

## Add Sudo Privileges
Add your user to the sudo group:

```bash
sudo adduser $USER sudo
```

## Clone Repo and Copy Config

Clone the debian-setup repo:

```bash
git clone https://github.com/matthewhartman/debian-setup.git --depth=1 && cd debian-setup
```

Copy the appropriate configuration files below

```bash
cp -a .config/* ~/.config

cp .xscreensaver ~/

cp -a .themes ~/.themes

sudo cp -a cuphead /usr/share/slim/themes/

```

Change the `current_theme` in slim.conf from `debian-lines` to `cuphead`

```bash
sudo nano /etc/slim.conf
```

## Install Google Chrome

Download and install Google Chrome:
https://www.google.com/chrome/

Remove chromium

```bash
sudo apt remove chromium
```

## Get rid of hanging network task

```bash
nano /etc/network/interfaces
```

Replace the contents below `source /etc/network/interfaces.d/*` with:

```bash
auto wlp1s0
```

## Fix PcSpkr Issue on Boot (optional)

If you see this error on boot `Error: Driver 'pcspkr' is already registered, aborting` - You can fix it by adding `blacklist pcspkr` to `/etc/modprobe.d/blacklist.conf`

## Install Sublime Text 3

Follow the instructions below:
https://www.sublimetext.com/docs/3/linux_repositories.html

Once you have downloaded and installed sublime, get up to speed with the following packages / config

- Install Package Control
- Install [HyperClick](https://github.com/aziz/SublimeHyperClick)
- Install Dracula Color Theme
- Create `JavaScript (Babel).sublime-settings` in `~/.config/sublime-text-3/Packages/User` and put in the following contents:

```json
{
  "extensions":
  [
    "js"
  ]
}
```

- Edit User Settings and replace all contents with the following:
    
```json
{
  "bold_folder_labels": true,
  "color_scheme": "Packages/Dracula Color Scheme/Dracula.tmTheme",
  "draw_minimap_border": true,
  "folder_exclude_patterns":
  [
    ".git",
    "node_modules",
    "build"
  ],
  "font_size": 11,
  "highlight_line": true,
  "highlight_modified_tabs": true,
  "ignored_packages":
  [
    "Vintage"
  ],
  "line_padding_bottom": 1,
  "line_padding_top": 1,
  "save_on_focus_lost": true,
  "tab_size": 2,
  "theme": "Adaptive.sublime-theme",
  "translate_tabs_to_spaces": true,
  "word_wrap": true,
  "scroll_past_end": false
}
```


Enjoy Sublime :)


## Install Node Version Manager

Follow the instructions for installing NVM from Github:
https://github.com/nvm-sh/nvm#install--update-script


## Install NodeJS and NPM

```bash
nvm install stable
```


## Install Bash Git Prompt

```bash
cd ~ && git clone https://github.com/magicmonty/bash-git-prompt.git .bash-git-prompt --depth=1
```

Add to `~/.bashrc`:

```bash
GIT_PROMPT_ONLY_IN_REPO=1
source ~/.bash-git-prompt/gitprompt.sh
```


## Enable CTRL + ALT + Backspace
You can restart X by pressing CTRL + ALT + Backpace. To enable this feature, simply run:

```bash
sudo dpkg-reconfigure keyboard-configuration
```

Go through the steps and at the very end, you will be prompted if you would like to enable CTRL + ALT + Backspace to restart X. Say yes and run `systemctl reboot`


## Fix Brightness - xbacklight

Check the backlight directory (you should see intel_backlight)

```bash
ls /sys/class/backlight
```

Get the Identifier (I had `0x46`)
```bash  
xrandr --verbose
```

Create an xorg.conf if you don't have one

```bash
cd /etc/X11/

sudo touch xorg.conf

sudo nano xorg.conf
```

Add the following to your xorg.conf

```bash
Section "Device"
  Identifier  "0x46"
  Driver      "intel"
  Option      "Backlight"  "intel_backlight"
EndSection
```

Reboot the machine.


## Install Steam

Go to Steam and download installer:

https://store.steampowered.com/


## Save Screenshots in Home Directory

```bash
gsettings set org.gnome.gnome-screenshot auto-save-directory "file:///home/$USER/"
```


## Install Greenclip

```bash
wget https://github.com/erebe/greenclip/releases/download/4.1/greenclip
```

Move greenclip to bin folder and make Greenclip executable

```bash
chmod +x greenclip && sudo mv greenclip /usr/bin/
```


## Enjoy your new setup

Like a boss :)


            /((((((\\\\
    =======((((((((((\\\\\
         ((           \\\\\\\
         ( (*    _/      \\\\\\\
           \    /  \      \\\\\\________________
            |  |   |       </                  ((\\\\
            o_|   /        /                      \ \\\\    \\\\\\\
                 |  ._    (                        \ \\\\\\\\\\\\\\\\
                 | /                       /       /    \\\\\\\     \\
         .______/\/     /                 /       /         \\\
        / __.____/    _/         ________(       /\
       / / / ________/`---------'         \     /  \_
      / /  \ \                             \   \ \_  \
     ( <    \ \                             >  /    \ \
      \/      \\_                          / /       > )
               \_|                        / /       / /
                                        _//       _//
                                       /_|       /_|
