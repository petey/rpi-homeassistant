DOCKER_IMAGE_VERSION=0.28.2
DOCKER_IMAGE_NAME=linuxpete/rpi-homeassistant
DOCKER_IMAGE_TAGNAME=$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION)

default: build

build:
	docker build -t $(DOCKER_IMAGE_TAGNAME) .
	docker tag $(DOCKER_IMAGE_TAGNAME) $(DOCKER_IMAGE_NAME):latest

push:
	docker push $(DOCKER_IMAGE_NAME)

test:
	cp configuration.yaml ~/.homeassistant/configuration.yaml
	docker run -d --name="home-assistant" --device /dev/ttyACM0:/dev/zwave -v ~/.homeassistant:/config -v /etc/localtime:/etc/localtime:ro --net=host $(DOCKER_IMAGE_NAME)
