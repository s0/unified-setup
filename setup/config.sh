#! /bin/bash

echo "Setting up lightdm"
systemctl enable lightdm
ln -sf /unified-setup/usr/share/xsessions/unified-setup.desktop /usr/share/xsessions/unified-setup.desktop
ln -sf /unified-setup/etc/lightdm/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf
ln -sf /unified-setup/etc/lightdm/lightdm.conf /etc/lightdm/lightdm.conf

echo "Linking / copying config"
ln -sf /unified-setup/etc/fish/conf.d/unified.fish /etc/fish/conf.d/unified.fish
cp /unified-setup/usr/lib/urxvt/perl/clipboard /usr/lib/urxvt/perl/clipboard
ln -sf /unified-setup/etc/gtk-2.0/gtkrc /etc/gtk-2.0/gtkrc
ln -sf /unified-setup/etc/gtk-3.0/settings.ini /etc/gtk-3.0/settings.ini
ln -sf /unified-setup/etc/i3/config /etc/i3/config
ln -sf /unified-setup/etc/gitconfig /etc/gitconfig
ln -sf /unified-setup/etc/tmux.conf /etc/tmux.conf
ln -sf /unified-setup/etc/xdg/dunstrc /etc/xdg/dunstrc
ln -sf /unified-setup/etc/pacman.d/hooks /etc/pacman.d/hooks

echo "Setting up firewall"
ln -sf /unified-setup/etc/iptables/iptables.rules /etc/iptables/iptables.rules
ln -sf /unified-setup/etc/iptables/ip6tables.rules /etc/iptables/ip6tables.rules
systemctl enable iptables
systemctl enable ip6tables
