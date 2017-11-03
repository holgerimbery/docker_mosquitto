TARGET ?= arm64
ARCHS ?= amd64 armhf
BASE_ARCH ?= arm64


build: tmp-$(TARGET)/Dockerfile
	docker build --build-arg ARCH=$(TARGET) --no-cache -t holgerimbery/docker_mosquitto:$(TARGET)-stretch tmp-$(TARGET)
	docker run --rm holgerimbery/docker_mosquitto:$(TARGET)-stretch uname -a


tmp-$(TARGET)/Dockerfile: Dockerfile $(shell find overlay-$(TARGET))
	rm -rf tmp-$(TARGET)
	mkdir tmp-$(TARGET)
	cp Dockerfile $@
	cp -rf overlay-$(TARGET) tmp-$(TARGET)/
	for arch in $(ARCHS); do                     \
	  if [ "$$arch" != "$(TARGET)" ]; then       \
	    sed -i "/arch=$$arch/d" $@;              \
	  fi;                                        \
	done
	sed -i '/#[[:space:]]*arch=$(TARGET)/s/^#//' $@
	sed -i 's/#[[:space:]]*arch=$(TARGET)//g' $@
	cat $@
  
