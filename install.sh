#!/bin/bash

# Check if the script is run with sudo privileges
if [ "$EUID" -ne 0 ]; then
    echo "This script must be run with sudo privileges. Please use 'sudo $0'"
    exit 1
fi

set -e

echo "Downloading and installing Librespeed-rs"
wget https://github.com/librespeed/speedtest-rust/releases/download/v1.3.6/librespeed-rs-x86_64-unknown-linux-gnu.deb
dpkg -i librespeed-rs-x86_64-unknown-linux-gnu.deb

echo "Downloading and replacing index.html"
wget -qO /var/lib/librespeed-rs/assets/index.html https://raw.githubusercontent.com/steveacab/librespeedtest-rs/refs/heads/main/index.html

echo "Opening configs.toml for editing. Please add your local IP address manually."
echo "Press any key to continue when you're ready to edit..."
read -n 1 -s

nano /var/lib/librespeed-rs/configs.toml

echo "Enabling and starting Librespeed-rs service"
systemctl enable --now librespeed-rs.service

sudo service librespeed-rs status

echo "Installation and configuration complete! Service commands:    start (sudo service librespeed-rs start),    stop (sudo service librespeed-rs stop),    status (sudo service librespeed-rs status)"
