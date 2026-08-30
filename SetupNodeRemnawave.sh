#!/bin/bash

source ./utils.sh
source ./check_system.sh
source ./setup_swap.sh
source ./update_system.sh

check_sys

if apt_update; then
    echo "Система успешно обновлена"
else
    echo "Ошибка при обновлении системы"
    exit 1
fi

if setup_swap; then
    echo "Успешно установлен файл подкачки размером ${NEED_SWAP_SIZE}G"

    # Показываем результат
    free -h
    swapon --show

    echo "Продолжение через:"

    for i in 3 2 1; do
        echo "$i"
        sleep 1
    done
else
    echo "Ошибка при настройке Swap"
    exit 1
fi