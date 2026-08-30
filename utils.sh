#!/bin/bash

run_command() {
    local MESSAGE="$1"
    shift

    "$@" > /dev/null 2>&1 &
    local PID=$!

    spinner "$PID" "$MESSAGE"

    wait "$PID"
    return $?
}

spinner() {
    local PID=$1
    local MESSAGE="$2"

    local FRAMES=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
    local i=0

    while kill -0 "$PID" 2>/dev/null; do
        printf "\r%s %s" "${FRAMES[i]}" "$MESSAGE"

        i=$(( (i + 1) % ${#FRAMES[@]} ))

        sleep 0.1
    done

    printf "\r\033[K"
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