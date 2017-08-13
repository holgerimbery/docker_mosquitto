#!/bin/bash
echo  please enter your username:
read username
echo  please enter your password:
read password

sed 's/##awesome_username##/'$username'/g' </mqtt/config/mosquitto_password.sh.template > /mqtt/config/mosquitto_password.sh.temp
sed 's/##awesome_password##/'$password'/g' </mqtt/config/mosquitto_password.sh.temp > /mqtt/config/mosquitto_password.sh
rm /mqtt/config/mosquitto_password.sh.temp
bash /mqtt/config/mosquitto_password.sh
