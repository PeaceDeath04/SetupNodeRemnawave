#!/bin/bash
source ./utils.sh

apt_update(){
    run_command apt update || return 1
    run_command apt upgrade -y || return 1
}
