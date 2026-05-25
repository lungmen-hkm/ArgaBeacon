#!/usr/bin/env bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0;3m'

RepoUrl="https://github.com/lungmen-hkm/ArgaBeacon.git"
FolderName="ArgaBeacon"

echo -e "${CYAN}--- Starting Process... ---${NC}"

if [ ! -d "$FolderName" ]; then
    echo -e "${GREEN}[*] Cloning repository ArgaBeacon...${NC}"
    git clone "$RepoUrl"
    if [ $? -ne 0 ]; then
        echo -e "${RED}[-] Failed to clone repository! Check your internet connection or Git installation.${NC}"
        exit 1
    fi
else
    echo -e "${YELLOW}[!] Folder $FolderName already exists, skipping clone.${NC}"
fi

cd "$FolderName" || exit 1

echo -e "${GREEN}[*] Ensuring PlatformIO Core is installed...${NC}"
python3 -m pip install -U platformio

if [ $? -ne 0 ]; then
    echo -e "${RED}[-] Failed to install PlatformIO via PIP. Is Python3-pip installed?${NC}"
    exit 1
fi

export PATH="$HOME/.local/bin:$PATH"

echo -e "${GREEN}[*] Compiling custom firmware (custom_esp32)...${NC}"
pio run -e custom_esp32

if [ $? -ne 0 ]; then
    echo -e "${RED}[-] Build failed! Check your code, there might be a typo somewhere.${NC}"
    exit 1
fi

echo -e "${YELLOW}[*] Please connect your ESP32 to the USB port.${NC}"
read -p "Once connected, press [ENTER] to continue..."

echo -e "${GREEN}[*] Flashing firmware to ESP32...${NC}"
pio run -e custom_esp32 -t upload

if [ $? -eq 0 ]; then
    echo -e "${GREEN}[+] Done!${NC}"
else
    echo -e "${RED}[-] Failed to flash firmware! Check the USB cable, or perhaps you forgot to set chmod on /dev/ttyUSB0?${NC}"
fi