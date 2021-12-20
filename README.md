# My Debian 11 (Bullseye) Setup

This is my nimble computer setup - a very lightweight Debian 11 (Bullseye) installation with Openbox and cool tweaks.

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
sudo dd if=debian-11.0.0-amd64-netinst.iso of=/dev/sdb# bs=4M; sync
```


## Installing Network Tools and Drivers

Before proceeding any further, make sure you login as root.


### Install Drivers:

Clone the following repo:

```bash
git clone https://github.com/OpenELEC/iwlwifi-firmware.git
```


## Updating Sources

`nano /etc/apt/sources.list`

```bash
deb http://deb.debian.org/debian bullseye main contrib non-free
deb http://deb.debian.org/debian bullseye-updates main contrib non-free
deb http://security.debian.org/debian-security bullseye-security main
deb http://ftp.debian.org/debian bullseye-backports main contrib non-free
```


## Install Packages

Once you are connected to the internet, upgrade your system and install the packages below:
    
```bash
sudo apt update && sudo apt upgrade -y && \
sudo apt install aptitude apt-transport-https libnotify-bin xorg \
openbox pulseaudio volumeicon-alsa obconf obmenu curl xclip p7zip htop \
rofi nitrogen tint2 nomacs xcompmgr zip thunar thunar-archive-plugin \
thunar-media-tags-plugin terminator lxappearance lxappearance-obconf \
git gitk autoconf libgtk-3-dev chromium xscreensaver xscreensaver-gl-extra \
xscreensaver-data-extra simplescreenrecorder simple-scan gnome-disk-utility \
ack-grep vlc libssl1.1 gsimplecal arandr dunst gnome-screenshot arc-theme \
neofetch fonts-noto-color-emoji dnsutils slim connman \
binutils build-essential arc-theme moka-icon-theme \
firmware-realtek connman-gtk -y
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


## Install Steam

Go to Steam and download installer:

https://store.steampowered.com/


## Save Screenshots in Home Directory

```bash
gsettings set org.gnome.gnome-screenshot auto-save-directory "file:///home/$USER/"
```


## Install Greenclip

```bash
wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip
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
