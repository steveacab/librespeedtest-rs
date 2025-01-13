#!/bin/bash

# Check if the script is run with sudo privileges
if [ "$EUID" -ne 0 ]; then
    echo "This script must be run with sudo privileges. Please use 'sudo $0'"
    exit 1
fi

set -e

echo "Downloading and installing Librespeed-rs"
wget -qO- https://github.com/librespeed/speedtest-rust/releases/download/v1.3.6/librespeed-rs-x86_64-unknown-linux-gnu.deb | dpkg -i -

echo "Modifying index.html"
wget -qO /var/lib/librespeed-rs/assets/index.html blob:https://github.com/fdb1cb26-2fdc-431a-b9c9-f0fe5f4395ea

echo "Enabling and starting Librespeed-rs service"
systemctl enable --now librespeed-rs.service

echo "Add local IP address manually:  "
nano /var/lib/librespeed-rs/configs.toml

echo "Service commands:   start (sudo service librespeed-rs start),   stop (sudo service librespeed-rs stop),   status (sudo service librespeed-rs status)"