# GPS Spoofing attack demo
Demonstrate a GPS spoofing attack.

## Installation
0. setup the base system as per `../../README.md` instructions
1. provide the ephemeris file as `./brdc`
2. provide the path to generate as `./waypoints.lla.csv`
3. run the Ansible Playbook:
   ```sh
   ansible-playbook -i ../../inventory --user <USER> gps-spoof.yml
   ```

## References
Check out the GPS signal simulator on [GitHub](https://github.com/osqzss/gps-sdr-sim) for details on the required files.
