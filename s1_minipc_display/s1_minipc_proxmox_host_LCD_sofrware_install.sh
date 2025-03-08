start() {
    if ! (whiptail --backtitle "S1 miniPC LCD DISPLAY TOOL for PROXMOX" --title "${APP} LXC" --yesno "Будет установлен софт для работы с дисплеем S1 miniPC на Proxmox ${APP}?             (не закрывайте\уходите из консоли до конца установки)   Начать создание контейнера?" 10 58); then
      clear
      exit_script
      exit
    fi
    echo -e "start_funcion_ended"
}

install() {
    echo -e "isntall_funcion_started"
    echo -e "start_funcion_ended"
}

start
install
