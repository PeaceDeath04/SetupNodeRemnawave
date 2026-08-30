#!/bin/bash

# Имя пользователя подключенного по ssh
#CURRENT_USER=$(whoami)

check_sys() {
# Проверка запуска скрипта с правами root
    if [[ "$EUID" -ne 0 ]]; then
        echo "Ошибка: скрипт нужно запускать с правами root"
        exit 1
    fi

    # Подгружаем переменные об os
    source /etc/os-release

    # проверка на рабочую os
    if [[ "$ID" == "ubuntu" && "$VERSION_ID" == "24.04" ]]; then
        echo "Ubuntu 24.04 обнаружена"
    else
        echo "Неподдерживаемая ОС , скрипт работает для версии Ubuntu 24.04"
        exit 1
    fi
}