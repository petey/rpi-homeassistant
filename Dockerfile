FROM linuxpete/rpi-openzwave

VOLUME /config

ADD https://raw.githubusercontent.com/home-assistant/home-assistant/dev/requirements_all.txt /tmp/requirements_all.txt

RUN apt-get update && \
    apt-get install -y --no-install-recommends python3-cffi python3-cryptography python3-netifaces python3-yaml python3-colorlog && \
    pip3 install -r /tmp/requirements_all.txt && \
    pip3 install homeassistant && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["hass", "--open-ui", "--config", "/config"]


