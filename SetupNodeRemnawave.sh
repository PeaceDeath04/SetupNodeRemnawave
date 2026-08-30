#!/bin/bash
source ./utils.sh
source ./check_system.sh
source ./setup_swap.sh

check_sys


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
fi