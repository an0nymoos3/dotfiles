#!/bin/bash

set -euxo pipefail

echo -e "######################################"
echo -e "######### Dotfiles installer ########"
echo -e "######################################"

sleep 2;

clear

echo -e "######################################"
echo -e "####### Configuring Pacman ... #######"
echo -e "######################################"

sed -i \
  -e '/^\s*#\[multilib\]/,/^\s*#Include = /s/^\s*#//' \
  -e 's/^\s*#VerbosePkgLists/VerbosePkgLists/' \
  -e '/^Color$/a ILoveCandy' \
  /etc/pacman.conf

sleep 2

clear

echo -e "######################################"
echo -e "####### Installing packages ... ######"
echo -e "######################################"

sleep 1;

pacman -S base-devel flatpak bazaar starship rustup python \
  uv hyprland noctalia noctalia-greeter wezterm nautilus \
  vim ttf-fira-code ttf-firacode-nerd ttf-jetbrains-mono \ 
  nerd-fonts go podman podman-compose protonup-qt steam \
  gamescope gamemode easyeffects fzf net-tools less hyprcursor \ 
  mangohud man-db mpv mold btop nvtop obs-studio umu-launcher \
  mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon \
  onefetch fastfetch polkit pavucontrol zathura zathura-pdf-mupdf \
  openrazer-daemon swappy v4l2loopback-dkms v4l2loopback-utils \
  wget curl wl-clipboard yt-dlp typst \

rustup default stable

clear

echo -e "######################################"
echo -e "### Installing flatpak packages... ###"
echo -e "######################################"

sleep 1

flatpak install flathub dev.vencord.Vesktop
flatpak install flathub one.ablaze.floorp # Primary browser
flatpak install flathub org.chromium.Chromium # Backup chromium based browser
flatpak install flathub com.spotify.Client

sleep 1

clear

echo -e "######################################"
echo -e "######### Installing paru ... ########"
echo -e "######################################"

sleep 1

git clone https://aur.archlinux.com/paru.git
cd paru/
makepkg -si

sleep 1

clear

echo -e "######################################"
echo -e "#### Installing paru packages ... ####"
echo -e "######################################"

sleep 1

paru -S neovim-nightly razergenie vscodium

sleep 1

clear

echo -e "######################################"
echo -e "######## Copying dotfiles ... ########"
echo -e "######################################"

sleep 1

cp -r dotfiles/* ~/.config/

# Move wezterm config to ~/
mv ~/.config/wezterm.lua ~/

# Move noctalia gui settings
mv ~/.config/noctalia/settings.toml ~/.local/state/noctalia/settings.toml

sleep 1

clear

echo -e "######################################"
echo -e "######## Configuring git ... #########"
echo -e "######################################"

sleep 1

echo -n "Enter GitHub email: " 
read gitemail

echo -n "Enter Uni Gitlab email: " 
read liuemail

echo -n "Enter lysator email: " 
read lysemail

ssh-keygen -C "$gitemail" -f ~/.ssh/gh_key
ssh-keygen -C "$liuemail" -f ~/.ssh/liu_key
ssh-keygen -C "$lysemail" -f ~/.ssh/lys_key

sleep 1

clear

echo -e "######################################"
echo -e "##### Copying useful scripts ... #####"
echo -e "######################################"

sleep 1

cp -r scripts/ ~/scripts/ 

sleep 1

clear


echo -e "######################################"
echo -e "######## Updating .bashrc ... ########"
echo -e "######################################"

cat <<'EOF' >> ~/.bashrc
eval "$(starship init bash)"

fastfetch

# uv
export PATH="$HOME/.local/bin:$PATH"
EOF

echo -e "######################################"
echo -e "####### Installation complete! #######"
echo -e "######################################"