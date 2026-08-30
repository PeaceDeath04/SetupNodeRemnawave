#!/bin/bash

source ./utils.sh

apt_update() {
    if ! run_command "Обновление списка пакетов..." apt-get update; then
        return 1
    fi

    if ! run_command "Обновление пакетов..." apt-get -y upgrade; then
        return 1
    fi
}