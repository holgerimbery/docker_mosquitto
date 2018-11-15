![Docker Pulls](https://img.shields.io/docker/pulls/holgerimbery/mosquitto.svg)![Travis](https://img.shields.io/travis/holgerimbery/docker_mosquitto.svg)
[![](https://images.microbadger.com/badges/image/holgerimbery/mosquitto.svg)](https://microbadger.com/images/holgerimbery/mosquitto "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/holgerimbery/mosquitto.svg)](https://microbadger.com/images/holgerimbery/mosquitto "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/holgerimbery/mosquitto:arm32v6.svg)](https://microbadger.com/images/holgerimbery/mosquitto:arm32v6 "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/holgerimbery/mosquitto:arm64v8.svg)](https://microbadger.com/images/holgerimbery/mosquitto:arm64v8 "Get your own version badge on microbadger.com")
## mosquitto mqtt broker (multiarch)
You can use this image as a container and as well as a service in a swarm.
For swarm usage, it´s recommended to use a distributed filesystem like glusterfs and map "local" directories to the service.

  * If you want to use mosquitto with passwords, generate a password file with mosquitto_passwd first and enable the usage of passwords afterwards.
  * For a quick start, you can use the sample configuration files provided on the docker_mosquitto github repository. Please copy them to your local config-directory and use the following flow to generate a password pair and start mqtt as a service on your swarm. A script will help you to generate a user-name / password pair.

### Supported architectures:
amd64, arm32v7, arm64v8


### Usage
(multiarch image - no need to specify architecture by adding architecture specific tag)

   * pull image
   
```
docker pull holgerimbery/mosquitto:latest
```
   
   * copy config files (github: directory config) to you local config - directory
   * generate username and password: start a container (please modify volume mapping according to your needs) on the master

```
docker run -it -v /srv/mosquitto/config/:/mqtt/config --entrypoint "/bin/bash" holgerimbery/mosquitto:latest
```

   * start password setup process
   
```
cd /mqtt/config && chmod 755 mosquitto_password_install.sh && ./mosquitto_password_install.sh
```

```
sh mosquitto_password.sh
```
   * edit /mqtt/config/conf.d/ssl.conf & /mqtt/config/conf.d/websocket_ssl.conf (path to certs)

   * exit & close the container
   
```
exit
```

   * start mosquitto as a service on your swarm:

```
docker service create --name mosquitto \
--mount type=bind,source=/srv/mosquitto/data,target=/mqtt/data \
--mount type=bind,source=/srv/mosquitto/config,target=/mqtt/config \
# --mount type=bind,source=/srv/letsencrypt/archive/domain.tdl,target=/mqtt/config/certs \
--mount type=bind,source=/srv/mosquitto/log,target=/mqtt/log \
--network ingress \
--publish 1883:1883 \
--publish 9001:9001 \
--publish 8883:8883 \
--publish 8030:8083 \
holgerimbery/mosquitto:latest
```

## License
MIT (c) 2017 Holger Imbery https://github.com/holgerimbery

![made-in-berlin](https://github.com/holgerimbery/environment/raw/master/made-in-berlin-badge_small.png)
