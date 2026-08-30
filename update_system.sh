#!/bin/bash

source ./utils.sh

apt_update() {
    run_command apt-get install pv -y
    echo "Обновление списка пакетов..."

    run_command apt-get update || return 1

    echo
    echo "Обновление пакетов..."

    sudo apt-get -y \
        -o Dpkg::Progress-Fancy="0" \
        -o Dpkg::Stdout-Filtering="0" \
        upgrade 2>&1 \
        | grep --line-buffered -oP 'Progress:\s*\[\s*\K\d+(?=%\])' \
        | pv -n -s 100 -p -F "Обновление пакетов %p%% [%b]" \
        > /dev/null

    local RESULT=${PIPESTATUS[0]}

    if [[ "$RESULT" -ne 0 ]]; then
        echo "[✗] Ошибка обновления пакетов"
        echo "[✗] Код ошибки: $RESULT"
        return "$RESULT"
    fi

    echo
    echo "[✓] Пакеты успешно обновлены"
}