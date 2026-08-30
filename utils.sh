#!/bin/bash
run_command() {
    "$@" > /dev/null
    local RESULT=$?

    if [[ "$RESULT" -ne 0 ]]; then
        echo "[✗] Ошибка: $*"
        echo "[✗] Код ошибки: $RESULT"
        return "$RESULT"
    fi
}
