# rpi-homeassistant
[Home Assistant](https://home-assistant.io/) for [raspberry pi3](https://www.raspberrypi.org/) in a [docker](https://www.docker.com/) container

Inspiration and some code from [thingspi](https://github.com/thingspi/rpi-homeassistant)

Available on docker hub: [linuxpete/rpi-homeassistant](https://hub.docker.com/r/linuxpete/rpi-homeassistant/)

## Building this image

### RPI setup
* Get the latest [Raspbian Jessie Lite](https://www.raspberrypi.org/downloads/raspbian/)
* Get [Etcher](https://www.etcher.io/)
* Use Etcher to burn the Raspbian image to an sd card, 16GB or higher, probably
* Mount the Raspbian image again and edit `/boot/config.txt` to add
```
gpu_mem=16
```
Since the rpi will be headless, there’s no need to give a ton of shared memory to the gpu.
* Boot up the pi, with monitor and keyboard attached. (ssh doesn't seem to be enabled by default)
* I always find that the image is set to `en.UK UTF-8` and my keyboard doesn’t have the right keymap. This can be fixed by changing the i18n settings with:
```
sudo raspi-config
```
You may need to restart after for settings to take effect. You can also take this time to enable the ssh server in advanced settings.
* We need to add the overlay kernel module:
```
echo "overlay" | sudo tee -a /etc/modules
```
* Also set up wifi:
```
echo 'network={
    ssid="your-ssid"
    psk="your-psk"
}' | sudo tee -a /etc/wpa_supplicant/wpa_supplicant.conf
```
* Resize the filesystem.
```
sudo raspi-config --expand-rootfs
```
* Reboot, and you should have wifi running, and ssh.
* Install docker
```
curl -sSL get.docker.com | sh
```
* configure docker to start on boot
```
sudo systemctl enable docker
```
* You should also be able to start docker manually, though docker wouldn’t work for me without a reboot, YMMV.
```
sudo systemctl start docker
```
* Give the pi user access to run docker commands:
```
sudo usermod -aG docker pi
```
* Reboot the pi, and docker should be running
```
docker images
```
* Optionally: Install docker compose
```
sudo apt-get update
sudo apt-get install -y apt-transport-https
echo "deb https://packagecloud.io/Hypriot/Schatzkiste/debian/ jessie main" | sudo tee /etc/apt/sources.list.d/hypriot.list
sudo apt-get update
sudo apt-get install docker-compose
```
### Building the image
* Clone this repo
* Change in to the repo's directory
* `make build`

### Testing the image
* `make test`
* Navigate in a browser to `http://your.rpi.ip:8123/`. It may take a little time for hass to spin up.
* `docker logs home-assistant` Will show you what the server is doing.
