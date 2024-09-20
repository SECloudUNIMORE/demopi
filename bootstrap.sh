#!/usr/bin/env bash

# Seed the Raspberry Pi OS image for headless operation
# (see https://www.raspberrypi.com/documentation/computers/configuration.html#remote-access)
# (see https://docs.ansible.com/ansible/latest/reference_appendices/faq.html#how-do-i-generate-encrypted-passwords-for-the-user-module)
#
# NOTE: this script uses yescrypt to hash the password.
#       (check `man 5 crypt` for the latest algorithm)
read -p "Username: " username
echo "$username:$(mkpasswd --method=yescrypt)" > userconf.txt
touch ssh
