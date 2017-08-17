
## mosquitto mqtt broker

you can use this image as a container and as a service in a swarm.

For swarm usage, use a distributed filesystem like glusterfs and map "local" directories to the service.

  * If you want to use mosquitto with passwords, generate a password file with mosquitto_passwd first and enable the usage of passwords afterwards.
  * If you use the sample configuration files on github, please copy them to your local config-directory and use the following flow to generate a password pair and start mqtt as a service on your swarm.


### Usage (architecture: amd64)

   * pull image docker poll holgerimbery/docker_mosquitto:latest on every node
   * copy config files (github: directory config) to you local config - directory
   * generate username and password:
   
     start a container (please modify volume mapping according to your needs) on the master
```
docker run -it -v /mnt/glusterfs/config/mqtt/config/:/mqtt/config --entrypoint "/bin/bash" holgerimbery/docker_mosquitto
```
         
   * start password setup process
```
cd /mqtt/config && chmod 755 mosquitto_password_install.sh && ./mosquitto_password_install.sh
```

   * exit & close the container
```
exit
```
         
   * start mosquitto as a service on your swarm:

```
docker service create --name mosquitto \
--mount type=bind,source=/mnt/glusterfs/config/mqtt/data,target=/mqtt/data \
--mount type=bind,source=/mnt/glusterfs/config/mqtt/config,target=/mqtt/config \
--mount type=bind,source=/mnt/glusterfs/config/mqtt/log,target=/mqtt/log \
--network ingress \
--publish 1883:1883 \
--publish 9001:9001 \
holgerimbery/docker_mosquitto
```

# usage (architecture: rpi)
* pull image docker poll holgerimbery/docker_mosquitto:rpi on every node
* follow the description above (architecture: amd64), but leave out the pull sequence mentioned there.

