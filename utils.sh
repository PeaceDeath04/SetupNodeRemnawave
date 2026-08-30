#!/bin/bash


run_command() {
    "$@"

    local RESULT=$?

    if [[ "$RESULT" -ne 0 ]]; then
        echo
        echo "========================================"
        echo "ОШИБКА"
        echo "Команда: $*"
        echo "Код ошибки: $RESULT"
        echo "========================================"
        return "$RESULT"
    fi
}