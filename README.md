Demo Pi
=======
A platform for showcasing activities based on Raspberry Pi hardware.

Installation
------------
1. write the Raspberry Pi OS image to a microSD card
2. run the `bootstrap.sh` script inside the `bootfs` partition
3. insert the card into the Raspberry Pi board and power it up
4. connect the Raspberry Pi board and the controlling machine to the same network
   (ensure your mDNS resolver is working properly)
5. authorize your SSH key:
   ```sh
   ssh-copy-id -i ~/.ssh/<ID_PRIV_KEY> <USER>@demopi.local
   ```
6. run the Ansible Playbook:
   ```sh
   ansible-playbook -i inventory --user <USER> main.yml
   ```

License
-------
This work is licensed under the terms and conditions of the MIT permissive license.
