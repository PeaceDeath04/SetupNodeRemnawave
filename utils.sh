#!/bin/bash

run_command() {
    "$@" > /dev/null

    local RESULT=$?

    if [[ "$RESULT" -ne 0 ]]; then
        echo
        echo "[✗] Ошибка: $*"
        echo "[✗] Код ошибки: $RESULT"
        return "$RESULT"
    fi
}

print_success() {
    echo "[✓] $1"
}

print_error() {
    echo "[✗] $1"
}

print_step() {
    echo
    echo "==> $1"
}

countdown() {
    echo
    echo "Продолжение через:"

    for i in 3 2 1; do
        echo "$i"
        sleep 1
    done

    echo
}