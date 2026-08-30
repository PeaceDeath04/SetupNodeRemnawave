#!/bin/bash

source ./utils.sh
source ./check_system.sh
source ./setup_swap.sh
source ./update_system.sh


print_step "Проверка системы"

if check_sys; then
    print_success "Система соответствует требованиям"
else
    exit 1
fi


print_step "Обновление системы"

if apt_update; then
    print_success "Система успешно обновлена"
else
    exit 1
fi


print_step "Настройка файла подкачки"

if setup_swap; then
    print_success "Swap успешно настроен: ${NEED_SWAP_SIZE}G"
else
    exit 1
fi