#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/tteck/Proxmox/main/misc/build.func)
# Copyright (c) 2024 samohosting.ru
# Author: samohosting.ru
# License: MIT
# https://github.com/some_link/LICENSE


echo -e "Loading..."
# cat <<"EOF"
#    _____         __  __  ____  _    _  ____   _____ _______ _____ _   _  _____   _____  _    _ 
#   / ____|  /\   |  \/  |/ __ \| |  | |/ __ \ / ____|__   __|_   _| \ | |/ ____| |  __ \| |  | |
#  | (___   /  \  | \  / | |  | | |__| | |  | | (___    | |    | | |  \| | |  __  | |__) | |  | |
#   \___ \ / /\ \ | |\/| | |  | |  __  | |  | |\___ \   | |    | | | . ` | | |_ | |  _  /| |  | |
#   ____) / ____ \| |  | | |__| | |  | | |__| |____) |  | |   _| |_| |\  | |__| |_| | \ \| |__| |
#  |_____/_/    \_|_|  |_|\____/|_|  |_|\____/|_____/   |_|  |_____|_| \_|\_____(_|_|  \_\\____/                                                                                                

# EOF
read -r -p "Может лучше пива? <y/N> " prompt
if [[ ${prompt,,} =~ ^(y|yes)$ ]]; then
  msg_info "Ищу ближайший магазин...\n"
  msg_ok "Близжайший магазин найден, выдвигаемся..\n"
 fi
   if [[ ${prompt,,} =~ ^(n|no)$ ]]; then
     msg_info "Установщик покидает чат\n"
     msg_ok "Completed Successfully!\n"
    fi
      msg_info "нет, не пить - нельзя\n"
      msg_ok "Кто не курит и не пьет, тот здоровеньким помрет!\n"
