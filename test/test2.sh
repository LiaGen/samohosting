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
 
 Вас приветствует samohosting.ru
 
EOF
}

echo -e "Loading..."
header_info

read -r -p "Вы хотите создать домашний сервер? <y/N> " prompt
if [[ ${prompt,,} =~ ^(y|yes)$ ]]; then
  read -r -p "Может лучше пива? <y/N> " prompt
    if [[ ${prompt,,} =~ ^(y|yes)$ ]]; then
      msg_info "Ищу ближайший магазин...\n"
      msg_ok "Близжайший магазин найден, выдвигаемся..\n"
    fi
fi
if [[ ${prompt,,} =~ ^(n|no)$ ]]; then
  msg_info "Установщик покидает чат\n"
  msg_ok "Кто не курит и не пьет, тот здоровеньким помрет!\n"
fi
