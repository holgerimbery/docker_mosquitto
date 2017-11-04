TARGET ?= arm64
ARCHS ?= amd64 armhf arm64 i386 ppc64el armel s390x
BASE_ARCH ?= arm64


build: tmp-$(TARGET)/Dockerfile
	docker build --build-arg ARCH=$(TARGET) --no-cache -t $(DOCKER_REPO):$(TARGET)-$(OS_VERSION) tmp-$(TARGET)
	docker run --rm $(DOCKER_REPO):$(TARGET)-$(OS_VERSION) uname -a


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
  
