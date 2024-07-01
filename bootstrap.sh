#!/usr/bin/env bash

# Seed the Raspberry Pi OS image for headless operation
# (see https://www.raspberrypi.com/documentation/computers/configuration.html#remote-access)
#
# NOTE: this script uses SHA-crypt to hash the password.
#       Pick a temporary password to initialize the system,
#       then remember to move to a different, stronger one
#       and hash it with yescrypt, a more secure algorithm.
#       (check `man 5 crypt` for the latest algorithm)
read -p "Username: " username
echo "$username:$(openssl passwd -6)" > userconf.txt
touch ssh
