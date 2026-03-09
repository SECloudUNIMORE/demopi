#!/usr/bin/env bash

# Seed the Raspberry Pi OS image for headless operation
# (see https://www.raspberrypi.com/documentation/computers/configuration.html#remote-access)

# 1. Set credentials for the system administrator
# (see https://docs.ansible.com/ansible/latest/reference_appendices/faq.html#how-do-i-generate-encrypted-passwords-for-the-user-module)
# (see "rootfs/usr/lib/systemd/system/userconfig.service")
# (see "rootfs/usr/lib/userconf-pi/userconf-service")
#
# NOTE: this script uses yescrypt to hash the password.
#       (check `man 5 crypt` for the latest algorithm)
read -p "Username: " username
echo "$username:$(mkpasswd --method=yescrypt)" > userconf.txt

# 2. Enable remote access through SSH
# (see "rootfs/usr/lib/systemd/system/sshswitch.service")
# (see "rootfs/usr/lib/raspberrypi-sys-mods/sshswitch")
touch ssh.txt

# 3. Set the hostname
# (see https://stackoverflow.com/questions/2642585/read-a-variable-in-bash-with-a-default-value/2642592#2642592)
# (see "rootfs/usr/lib/raspberrypi-sys-mods/imager_custom")
# (see "rpi-imager/src/customization_generator.cpp")
# (see "rpi-imager/src/downloadthread.cpp")
# (see `man systemd-run-generator`)
# (see `man systemd.unit`)
read -p "Hostname [demopi]: " hostname
hostname=${hostname:-demopi}
cat > firstboot.sh << EOF
#!/bin/sh
set +e

if [ -f /usr/lib/raspberrypi-sys-mods/imager_custom ]; then
	/usr/lib/raspberrypi-sys-mods/imager_custom set_hostname $hostname
fi

rm -f /boot/firstboot.sh

sed -i 's|systemd.run=/boot/firstboot.sh systemd.run_success_action=reboot systemd.run_failure_action=none ||g' /boot/cmdline.txt
EOF
chmod a+x firstboot.sh
# NOTE: this script should be running inside the root directory of the
#       "bootfs" partition, thus "cmdline.txt" is expected to be there.
sed -i 's|^|systemd.run=/boot/firstboot.sh systemd.run_success_action=reboot systemd.run_failure_action=none |' cmdline.txt
