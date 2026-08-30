#!/bin/bash


setup_swap() {
    while true; do

        read -p "Введите размер файла подкачки в ГБ: " NEED_SWAP_SIZE

        if [[ "$NEED_SWAP_SIZE" =~ ^[0-9]+$ ]]; then

            if [[ "$SWAP_SIZE" != "${NEED_SWAP_SIZE}G" ]]; then

                run_command swapoff /swapfile || return 1
                run_command rm /swapfile || return 1
                run_command fallocate -l "${NEED_SWAP_SIZE}G" /swapfile || return 1
                run_command chmod 600 /swapfile || return 1
                run_command mkswap /swapfile || return 1
                run_command swapon /swapfile || return 1

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