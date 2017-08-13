#!/bin/bash
username=$(whiptail --passwordbox "please enter your username" 8 78 --title "MQTT username dialog" 3>&1 1>&2 2>&3)
password=$(whiptail --passwordbox "please enter your password" 8 78 --title "MQTT password dialog" 3>&1 1>&2 2>&3)

sed 's/##awesome_username##/'$username'/g' </mqtt/config/mosquitto_password.sh.template > /mqtt/config/mosquitto_password.sh.temp
sed 's/##awesome_password##/'$password'/g' </mqtt/config/mosquitto_password.sh.temp > /mqtt/config/mosquitto_password.sh
rm /mqtt/config/mosquitto_password.sh.temp
bash /mqtt/config/mosquitto_password.sh
