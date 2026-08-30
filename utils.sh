#!/bin/bash

run_command() {
    local MESSAGE="$1"
    shift

    local TMP_FILE
    TMP_FILE=$(mktemp)

    "$@" >"$TMP_FILE" 2>&1 &
    local PID=$!

    spinner "$PID" "$MESSAGE"

    wait "$PID"
    local STATUS=$?

    if [[ $STATUS -ne 0 ]]; then
        printf "\r\033[K"
        print_error "$MESSAGE"

        if [[ -s "$TMP_FILE" ]]; then
            sed 's/^/    /' "$TMP_FILE"
        fi

        rm -f "$TMP_FILE"
        return "$STATUS"
    fi

    rm -f "$TMP_FILE"
    return 0
}

spinner() {
    local PID=$1
    local MESSAGE="$2"

    local FRAMES=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
    local i=0

    while true; do
        local STATUS

        STATUS=$(ps -o stat= -p "$PID" 2>/dev/null)

        if [[ -z "$STATUS" || "$STATUS" == Z* ]]; then
            break
        fi

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