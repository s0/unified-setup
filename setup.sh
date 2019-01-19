#! /bin/bash

pushd /unified-setup

git submodule update --init

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
pacman -S base-devel python3 python-pip git emacs-nox tmux pkgfile net-tools rxvt-unicode-terminfo fish wget
pip install passphraseme
# GUI
pacman -S i3 python-setuptools xorg-server xorg lightdm lightdm-gtk-greeter rxvt-unicode chromium ttf-dejavu feh xcompmgr xclip dmenu redshift numix-gtk-theme thunar gnome-calculator dunst pulseaudio pavucontrol file-roller accountsservice

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
wget https://archive.archlinux.org/packages/g/gtk3/gtk3-3.22.9-1-x86_64.pkg.tar.xz
wget https://archive.archlinux.org/packages/g/gtk3/gtk3-3.22.9-1-x86_64.pkg.tar.xz.sig
pacman-key -v gtk3-3.22.9-1-x86_64.pkg.tar.xz.sig
echo ""
echo ""
echo "######### WARNING: Check signature above before installing"
echo ""
pacman -U gtk3-3.22.9-1-x86_64.pkg.tar.xz
popd

echo "installing themes"
/unified-setup/external/vertex-theme-install
/unified-setup/external/numix-icons-install

echo "Updating pkgfile index"
pkgfile --update

echo "Setting up lightdm"
systemctl enable lightdm
ln -s /unified-setup/usr/share/xsessions/unified-setup.desktop /usr/share/xsessions/unified-setup.desktop
rm /etc/lightdm/lightdm-gtk-greeter.conf
rm /etc/lightdm/lightdm.conf
ln -s /unified-setup/etc/lightdm/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf
ln -s /unified-setup/etc/lightdm/lightdm.conf /etc/lightdm/lightdm.conf

echo "Installing AUR packages"
/unified-setup/aur/i3ipc-python-install
/unified-setup/aur/aurget-install

# setting up config
ln -s /unified-setup/etc/fish/conf.d/unified.fish /etc/fish/conf.d/unified.fish
cp /unified-setup/usr/lib/urxvt/perl/clipboard /usr/lib/urxvt/perl/clipboard
ln -s /unified-setup/etc/gtk-2.0/gtkrc /etc/gtk-2.0/gtkrc
ln -s /unified-setup/etc/gtk-3.0/settings.ini /etc/gtk-3.0/settings.ini
ln -sf /unified-setup/etc/i3/config /etc/i3/config
ln -s /unified-setup/etc/gitconfig /etc/gitconfig
ln -s /unified-setup/etc/tmux.conf /etc/tmux.conf

popd
