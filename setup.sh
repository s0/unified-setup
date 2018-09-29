#! /bin/bash

#Configure networking using systemd-networkd
#systemctl enable systemd-networkd
#systemctl start systemd-networkd
#systemctl enable systemd-resolved
#systemctl start systemd-resolved
#ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf 
#TODO: Configure network interfaces in /etc/systemd/network/

echo "Installing Packages"
pacman -S git emacs-nox i3 xorg-server xorg lightdm lightdm-deepin-greeter tmux pkgfile net-tools

echo "Updating pkgfile index"
pkgfile --update

echo "Setting up lightdm"
systemctl enable lightdm
# TODO: configure /etc/lightdm/lightdm.conf to use lightdm-deepin-greeter
ln -s /unified-setup/usr/share/xsessions/unified-setup.desktop /usr/share/xsessions/unified-setup.desktop
# TODO: configure lightdm to use 

echo "Setting up users"
useradd sam
mkdir ~sam
chown sam:sam ~sam
echo "Enter password for user sam"
passwd sam

# TODO: link /home files (for all users)
