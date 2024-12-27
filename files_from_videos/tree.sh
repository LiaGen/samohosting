#!/usr/bin/env bash
# Copyright (c) 2024 samohosting.ru
# Author: samohosting.ru
# License: MIT
# https://github.com/some_link/LICENSE


# This function sets various color variables using ANSI escape codes for formatting text in the terminal.
color() {
  YW=$(echo "\033[33m")
  BL=$(echo "\033[36m")
  RD=$(echo "\033[01;31m")
  BGN=$(echo "\033[4;92m")
  GN=$(echo "\033[1;92m")
  DGN=$(echo "\033[32m")
  CL=$(echo "\033[m")
  CM="${GN}✓${CL}"
  CROSS="${RD}✗${CL}"
  BFR="\\r\\033[K"
  HOLD=" "
}

# This function enables error handling in the script by setting options and defining a trap for the ERR signal.
catch_errors() {
  set -Eeuo pipefail
  trap 'error_handler $LINENO "$BASH_COMMAND"' ERR
}

# This function is called when an error occurs. It receives the exit code, line number, and command that caused the error, and displays an error message.
error_handler() {
  if [ -n "$SPINNER_PID" ] && ps -p $SPINNER_PID > /dev/null; then kill $SPINNER_PID > /dev/null; fi
  printf "\e[?25h"
  local exit_code="$?"
  local line_number="$1"
  local command="$2"
  local error_message="${RD}[ERROR]${CL} in line ${RD}$line_number${CL}: exit code ${RD}$exit_code${CL}: while executing command ${YW}$command${CL}"
  echo -e "\n$error_message\n"
}

# This function displays a spinner.
spinner() {
    local chars="/-\|"
    local spin_i=0
    printf "\e[?25l"
    while true; do
        printf "\r \e[36m%s\e[0m" "${chars:spin_i++%${#chars}:1}"
        sleep 0.1
    done
}

# This function displays an informational message with a yellow color.
msg_info() {
  local msg="$1"
  echo -ne " ${HOLD} ${YW}${msg}   "
  spinner &
  SPINNER_PID=$!
}

# This function displays a success message with a green color.
msg_ok() {
  if [ -n "$SPINNER_PID" ] && ps -p $SPINNER_PID > /dev/null; then kill $SPINNER_PID > /dev/null; fi
  printf "\e[?25h"
  local msg="$1"
  echo -e "${BFR} ${CM} ${GN}${msg}${CL}"
}

# This function displays a error message with a red color.
msg_error() {
  if [ -n "$SPINNER_PID" ] && ps -p $SPINNER_PID > /dev/null; then kill $SPINNER_PID > /dev/null; fi
  printf "\e[?25h"
  local msg="$1"
  echo -e "${BFR} ${CROSS} ${RD}${msg}${CL}"
}

function header_info {
  clear
  cat <<"EOF"
   _____         __  __  ____  _    _  ____   _____ _______ _____ _   _  _____   _____  _    _ 
  / ____|  /\   |  \/  |/ __ \| |  | |/ __ \ / ____|__   __|_   _| \ | |/ ____| |  __ \| |  | |
 | (___   /  \  | \  / | |  | | |__| | |  | | (___    | |    | | |  \| | |  __  | |__) | |  | |
  \___ \ / /\ \ | |\/| | |  | |  __  | |  | |\___ \   | |    | | | . ` | | |_ | |  _  /| |  | |
  ____) / ____ \| |  | | |__| | |  | | |__| |____) |  | |   _| |_| |\  | |__| |_| | \ \| |__| |
 |_____/_/    \_|_|  |_|\____/|_|  |_|\____/|_____/   |_|  |_____|_| \_|\_____(_|_|  \_\\____/        
 
 Вас приветствует русскоязычный помощник-скрпитовик от samohosting.ru
 
EOF
}

echo -e "Loading..."
header_info

read -r -p "Хотите украсить Ваш сервер? <y/n> " prompt
if [[ ${prompt,,} =~ ^(y|yes)$ ]]; then
  read -r -p "Загадайте желание и нажмите "y" и enter <y/n> " prompt
    if [[ ${prompt,,} =~ ^(y|yes)$ ]]; then
      msg_info "Ищу самую красивую елку...\n"
        sleep 2.0
      msg_ok "Самая красивая елка найдена!..вжик вжик..(звуки пилы)..сейчас покажу..\n"
        sleep 3.0
        trap "tput reset; tput cnorm; exit" 2
        clear
        tput civis
        lin=2
        col=$(($(tput cols) / 2))
        c=$((col-1))
        est=$((c-2))
        color=0
        tput setaf 2; tput bold
        
        # Tree
        for ((i=1; i<20; i+=2))
        {
            tput cup $lin $col
            for ((j=1; j<=i; j++))
            {
                echo -n \*
            }
            let lin++
            let col--
        }
        
        tput sgr0; tput setaf 3
        
        # Trunk
        for ((i=1; i<=2; i++))
        {
            tput cup $((lin++)) $c
            echo 'mWm'
        }
        new_year=$(date +'%Y')
        let new_year++
        tput setaf 1; tput bold
        tput cup $lin $((c - 7)); echo Дорогие самохостята,
        tput cup $((lin + 1)) $((c - 12)); echo С наступающим Вас новым годом!
        tput cup $((lin + 2)) $((c - 15)); echo И удачного САМОХОСТИНГА в $new_year году
        let c++
        k=1
        
        # Lights and decorations
        while true; do
            for ((i=1; i<=35; i++)) {
                # Turn off the lights
                [ $k -gt 1 ] && {
                    tput setaf 2; tput bold
                    tput cup ${line[$[k-1]$i]} ${column[$[k-1]$i]}; echo \*
                    unset line[$[k-1]$i]; unset column[$[k-1]$i]  # Array cleanup
                }
        
                li=$((RANDOM % 9 + 3))
                start=$((c-li+2))
                co=$((RANDOM % (li-2) * 2 + 1 + start))
                tput setaf $color; tput bold   # Switch colors
                tput cup $li $co
                echo o
                line[$k$i]=$li
                column[$k$i]=$co
                color=$(((color+1)%8))
                # Flashing text
                sh=-5
                for l in С А М О Х О С Т И Н Г А
                do
                    tput cup $((lin+2)) $((c+sh))
                    echo $l
                    let sh++
                    sleep 0.01
                done
            }
            k=$((k % 2 + 1))
        done
    fi
fi
if [[ ${prompt,,} =~ ^(n|no)$ ]]; then
  msg_info "Скрипт завершает работу\n"
  msg_ok "С наступающим новым годом!\n"
fi
