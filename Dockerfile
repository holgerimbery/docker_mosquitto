FROM holgerimbery/debian:arm64-stretch
#FROM holgerimbery/debian:arm64-stretch # arch=amd64
ARG ARCH=arm64

MAINTAINER Holger Imbery <contact@connectedobjects.cloud>
LABEL version="1.2" \
      description="mosquitto mqtt brocker"

ADD https://repo.mosquitto.org/debian/mosquitto-repo.gpg.key .
RUN apt-key add mosquitto-repo.gpg.key
ADD https://repo.mosquitto.org/debian/mosquitto-stretchlist /etc/apt/sources.list.d/

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y mosquitto build-essentials && \
    rm -f mosquitto-repo.gpg.key \
    rm -rf /var/lib/apt/lists/*

RUN adduser --system --disabled-password --disabled-login mosquitto

VOLUME ["/mqtt/data", "/mqtt/config", "/mqtt/log"]
EXPOSE 1883 9001
CMD ["/usr/sbin/mosquitto", "-c", "/mqtt/config/mosquitto.conf"]
