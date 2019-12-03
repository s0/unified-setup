#! /bin/bash

set -e

pushd /unified-setup

git submodule update --init --recursive

#Configure networking using systemd-networkd
systemctl enable systemd-networkd
#systemctl start systemd-networkd
systemctl enable systemd-resolved
#systemctl start systemd-resolved
#ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf
echo "Configure network interfaces in /etc/systemd/network/, then exit"
bash

echo "Installing Packages"

# NON GUI
pacman -S base-devel python3 python-pip git emacs-nox tmux pkgfile net-tools rxvt-unicode-terminfo fish wget openssh bind-tools
pip install passphraseme
# GUI
pacman -S i3 python-setuptools xorg-server xorg lightdm lightdm-gtk-greeter rxvt-unicode chromium ttf-dejavu ttf-droid feh xcompmgr xclip dmenu redshift thunar gnome-calculator dunst pulseaudio pavucontrol file-roller accountsservice nodejs acpi

echo "Setting up root user"
chsh -s /usr/bin/fish

# user sam must be set up before installing any AUR packages
echo "Setting up users"
useradd sam
mkdir ~sam
chown sam:sam ~sam
chsh -s /usr/bin/fish sam
echo "Enter password for user sam"
passwd sam

# Downgrade gtk to 3.22 for compatibility with Vertex Theme

pushd /var/cache/pacman/pkg/
wget https://archive.archlinux.org/packages/g/gtk3/gtk3-3.22.30-1-x86_64.pkg.tar.xz
wget https://archive.archlinux.org/packages/g/gtk3/gtk3-3.22.30-1-x86_64.pkg.tar.xz.sig
pacman-key -v gtk3-3.22.30-1-x86_64.pkg.tar.xz.sig
echo ""
echo ""
echo "######### WARNING: Check signature above before installing"
echo ""
pacman -U gtk3-3.22.30-1-x86_64.pkg.tar.xz
popd

echo "installing themes"
/unified-setup/external/vertex-theme-install
/unified-setup/external/numix-icons-install

echo "Updating pkgfile index"
pkgfile --update

# Setup Core Config
/unified-setup/setup/config.sh

echo "Installing AUR packages"
/unified-setup/aur/i3ipc-python-install
/unified-setup/aur/aurget-install
# razer keyboard
/unified-setup/aur/openrazer-meta-install
# snapd dependencies
pacman -S go go-tools python-docutils apparmor squashfs-tools xfsprogs
/unified-setup/aur/snapd-install

# install synesthesia
/unified-setup/opt/synesthesia/install

popd
