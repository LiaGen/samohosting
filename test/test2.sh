#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/tteck/Proxmox/main/misc/build.func)
# Copyright (c) 2021-2024 tteck
# Author: tteck (tteckster)
# License: MIT
# https://github.com/tteck/Proxmox/raw/main/LICENSE

function header_info {
clear
cat <<"EOF"
   _____         __  __  ____  _    _  ____   _____ _______ _____ _   _  _____   _____  _    _ 
  / ____|  /\   |  \/  |/ __ \| |  | |/ __ \ / ____|__   __|_   _| \ | |/ ____| |  __ \| |  | |
 | (___   /  \  | \  / | |  | | |__| | |  | | (___    | |    | | |  \| | |  __  | |__) | |  | |
  \___ \ / /\ \ | |\/| | |  | |  __  | |  | |\___ \   | |    | | | . ` | | |_ | |  _  /| |  | |
  ____) / ____ \| |  | | |__| | |  | | |__| |____) |  | |   _| |_| |\  | |__| |_| | \ \| |__| |
 |_____/_/    \_|_|  |_|\____/|_|  |_|\____/|_____/   |_|  |_____|_| \_|\_____(_|_|  \_\\____/                                                                                                

EOF
}
header_info
echo -e "Loading..."
APP="Docker"
var_disk="4"
var_cpu="2"
var_ram="2048"
var_os="debian"
var_version="12"
variables
color
catch_errors

function default_settings() {
  CT_TYPE="1"
  PW=""
  CT_ID=$NEXTID
  HN=$NSAPP
  DISK_SIZE="$var_disk"
  CORE_COUNT="$var_cpu"
  RAM_SIZE="$var_ram"
  BRG="vmbr0"
  NET="dhcp"
  GATE=""
  APT_CACHER=""
  APT_CACHER_IP=""
  DISABLEIP6="no"
  MTU=""
  SD=""
  NS=""
  MAC=""
  VLAN=""
  SSH="no"
  VERB="no"
  echo_default
}

function update_script() {
header_info
if [[ ! -d /var ]]; then msg_error "No ${APP} Installation Found!"; exit; fi
msg_info "Updating ${APP} LXC"
apt-get update &>/dev/null
apt-get -y upgrade &>/dev/null
msg_ok "Updated ${APP} LXC"
exit
}
clear
cat <<"EOF"
   _____         __  __  ____  _    _  ____   _____ _______ _____ _   _  _____   _____  _    _ 
  / ____|  /\   |  \/  |/ __ \| |  | |/ __ \ / ____|__   __|_   _| \ | |/ ____| |  __ \| |  | |
 | (___   /  \  | \  / | |  | | |__| | |  | | (___    | |    | | |  \| | |  __  | |__) | |  | |
  \___ \ / /\ \ | |\/| | |  | |  __  | |  | |\___ \   | |    | | | . ` | | |_ | |  _  /| |  | |
  ____) / ____ \| |  | | |__| | |  | | |__| |____) |  | |   _| |_| |\  | |__| |_| | \ \| |__| |
 |_____/_/    \_|_|  |_|\____/|_|  |_|\____/|_____/   |_|  |_____|_| \_|\_____(_|_|  \_\\____/                                                                                                

EOF
read -r -p "Может лучше пива? <y/N> " prompt
if [[ ${prompt,,} =~ ^(y|yes)$ ]]; then
  msg_info "Installing Portainer $PORTAINER_LATEST_VERSION"
  docker volume create portainer_data >/dev/null
  $STD docker run -d \
    -p 8000:8000 \
    -p 9443:9443 \
    --name=portainer \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer-ce:latest
  msg_ok "Installed Portainer $PORTAINER_LATEST_VERSION"
start
build_container
description





msg_ok "Completed Successfully!\n"
