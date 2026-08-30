#!/bin/bash
SWAP_SIZE=$(swapon --show --noheadings | awk '{print $3}')
setup_swap() {
    while true; do

        read -p "Введите размер файла подкачки в ГБ: " NEED_SWAP_SIZE

        if [[ "$NEED_SWAP_SIZE" =~ ^[0-9]+$ ]]; then

            if [[ "$SWAP_SIZE" != "${NEED_SWAP_SIZE}G" ]]; then

                run_command "Отключение Swap..." swapoff /swapfile || return 1
                run_command "Удаление старого Swap..." rm /swapfile || return 1
                run_command "Создание Swap..." fallocate -l "${NEED_SWAP_SIZE}G" /swapfile || return 1
                run_command "Настройка прав Swap..." chmod 600 /swapfile || return 1
                run_command "Создание файловой системы Swap..." mkswap /swapfile || return 1
                run_command "Включение Swap..." swapon /swapfile || return 1

                break

            else

                echo "Swap уже имеет размер ${NEED_SWAP_SIZE}G"
                break

            fi

        else

            echo "Ошибка: необходимо ввести целое число"

        fi

    done
}