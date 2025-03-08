# PVE Install script and added theme:
    # Copyright (c) 2025 samohosting.ru
    # Author: liagen
    # License: MIT | https://raw.githubusercontent.com/samohosting-ru/samohosting-scripts/ru_dev/LICENSE
# LCD Software 
    # Author: tjaworski
    # Github: https://github.com/tjaworski/AceMagic-S1-LED-TFT-Linux/tree/main/s1panel
    # License: MIT | https://github.com/tjaworski/AceMagic-S1-LED-TFT-Linux/blob/main/LICENSE


start() {
    if ! (whiptail --backtitle "S1 miniPC LCD DISPLAY TOOL for PROXMOX" --title "S1 miniPC LCD DISPLAY TOOL for PROXMOX" --yesno "Будет установлен софт для работы с дисплеем S1 miniPC на Proxmox(не закрывайте\уходите из консоли до конца установки) Начать устаановку?" 10 58); then
      clear
      echo -e "Утсановка прервана пользователем"
      exit
    fi
    echo -e "INFO: start_funcion_ended"
}

install_requirements() {
    echo -e "INFO: install_requirements_funcion_started"
    echo -e "INFO: updating system repos.."
    apt update
    echo -e "INFO: installing nvm.."
    bash -c "$(wget -qLO - https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh)"
    echo -e "INFO: nvm installed"
    echo -e "INFO: switching to nvm.."
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    echo -e "INFO: installing nvm 18.13.0 and npm@9.2.0 "
    nvm install 18.13.0
    nvm use 18.13.0
    npm install -g npm@9.2.0
    echo -e "INFO: installed nvm 18.13.0 and npm@9.2.0 "
    echo -e "INFO: installing git.."
    apt -y install git
    echo -e "INFO: git installed"
}

install_lcd_software() {
    echo -e "INFO: cloning acemagic git repo into folder s1display"
    git clone https://github.com/tjaworski/AceMagic-S1-LED-TFT-Linux.git s1display
    echo -e "INFO: installing s1panel.."
    cd s1display/s1panel
    ./install
}

install_samohosting_theme() {
    echo -e "INFO: loading theme samohosting.."
    mkdir -p /s1display/s1panel/themes/samohosting
    wget -qO- https://github.com/LiaGen/samohosting/raw/main/s1_minipc_display/samohosting.tar.gz | tar -xz -C /s1display/s1panel/themes/samohosting --strip-components=1
    wget -qO- https://raw.githubusercontent.com/LiaGen/samohosting/refs/heads/main/s1_minipc_display/samohosting/config.json  -O /s1display/s1panel/config.json
    echo -e "INFO: theme samohosting loaded"
    echo -e "INFO: restarting s1panel service"
    systemctl daemon-reload
    systemctl restart s1panel.service
}

start
install_requirements
install_lcd_software
install_samohosting_theme
echo -e "INFO: install finished. Enjoy =)"
