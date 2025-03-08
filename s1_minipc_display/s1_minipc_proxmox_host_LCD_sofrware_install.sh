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
    echo -e "start_funcion_ended"
}

install_requirements() {
    echo -e "install_requirements_funcion_started"
    echo -e "installing nvm.."
    bash -c "$(wget -qLO - https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh)"
    echo -e "nvm installed"
    echo -e "installing nvm 18.13.0 and npm@9.2.0 "
    nvm install 18.13.0
    nvm use 18.13.0
    npm install -g npm@9.2.0
    echo -e "installed nvm 18.13.0 and npm@9.2.0 "
    echo -e "installing git.."
    apt -y install git
    echo -e "git installed"
}

install_lcd_software() {
    echo -e "cloning acemagic git repo into folder s1display"
    git clone https://github.com/tjaworski/AceMagic-S1-LED-TFT-Linux.git s1display
    echo -e "installing s1panel.."
    cd s1display/s1panel
    sudo ./install
}

install_samohosting_theme() {
    echo -e "install_samohosting_theme func is to be made"
}

start
install_requirements
install_lcd_software
install_samohosting_theme
