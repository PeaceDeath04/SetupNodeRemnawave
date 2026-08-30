#!/bin/bash

source ./utils.sh

apt_update() {

    echo "Обновление списка пакетов..."

    run_command apt-get update || return 1

    echo
    echo "Обновление пакетов..."

    apt-get \
        -y \
        -o Dpkg::Progress-Fancy="1" \
        upgrade

    local RESULT=$?

    if [[ "$RESULT" -ne 0 ]]; then
        echo
        echo "[✗] Ошибка обновления пакетов"
        echo "[✗] Код ошибки: $RESULT"
        return "$RESULT"
    fi

    echo
    echo "[✓] Пакеты успешно обновлены"
}