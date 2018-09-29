#! /bin/bash

pushd /unified-setup

git submodule update --init

#Configure networking using systemd-networkd
#systemctl enable systemd-networkd
#systemctl start systemd-networkd
#systemctl enable systemd-resolved
#systemctl start systemd-resolved
#ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf
#TODO: Configure network interfaces in /etc/systemd/network/

echo "Installing Packages"

# NON GUI
pacman -S base-devel python3 git emacs-nox tmux pkgfile net-tools rxvt-unicode-terminfo
# GUI
pacman -S i3 python-setuptools xorg-server xorg lightdm lightdm-gtk-greeter rxvt-unicode chromium ttf-dejavu

echo "Updating pkgfile index"
pkgfile --update

echo "Setting up lightdm"
systemctl enable lightdm
# TODO: configure /etc/lightdm/lightdm.conf to use lightdm-gtk-greeter
ln -s /unified-setup/usr/share/xsessions/unified-setup.desktop /usr/share/xsessions/unified-setup.desktop
# TODO: configure lightdm to use unified-session

echo "Installing AUR packages"
/unified-setup/aur/i3ipc-python-install

echo "Setting up users"
useradd sam
mkdir ~sam
chown sam:sam ~sam
echo "Enter password for user sam"
passwd sam

# TODO: link /home files (for all users)

popd
