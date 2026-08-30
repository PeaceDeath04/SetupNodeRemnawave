#!/bin/bash

# Имя пользователя подключенного по ssh
#CURRENT_USER=$(whoami)

check_sys() {
    if [[ "$EUID" -ne 0 ]]; then
        return 1
    fi

    source /etc/os-release

    if [[ "$ID" == "ubuntu" && "$VERSION_ID" == "24.04" ]]; then
        return 0
    fi

    return 1
}