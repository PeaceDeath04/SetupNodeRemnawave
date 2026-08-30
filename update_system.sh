#!/bin/bash
source ./utils.sh

apt_update(){
    run_command apt-get update || return 1
    run_command apt-get upgrade -y || return 1
}
