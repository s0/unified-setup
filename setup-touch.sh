#! /bin/bash

set -e

pushd /unified-setup

# Packages
sudo pacman -S onboard

# Onboard Config
gsettings set org.onboard theme '/unified-setup/config/onboard/Unified.theme'
gsettings set org.onboard layout '/usr/share/onboard/layouts/Full Keyboard.onboard'
gsettings set org.onboard system-theme-tracking-enabled false
gsettings set org.onboard xembed-background-color '#0000007F'

popd
