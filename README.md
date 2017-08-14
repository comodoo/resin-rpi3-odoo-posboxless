# resin-rpi3-odoo-posboxless
Docker to run Odoo Posboxless on a Raspberrypi3 with ResinOS

## HOWTO install an Odoo POS in a Raspberrypi3 with ResinOS
1. Go to [ResinOS webpage](https://resinos.io/) and follow the instructions in [Getting Started on the Raspberrypi3](https://resinos.io/docs/raspberrypi3/gettingstarted/) until you boot the board, you do not need to install any demo container.
2. Download resin-electronjs repository: `git clone https://github.com/resin-io/resin-electronjs.git; cd resin-electronjs`
3. Copy `Dockerfile.template`: `cp Dockerfile.template Dockerfile`
4. Edit `Dockerfile`. Replace `FROM resin/%%RESIN_MACHINE_NAME%%-node:6` with `FROM resin/raspberrypi3-node:6`
5. Install resin-electronjs container into the Raspberrypi3: `sudo resin local push resin.local -s . -e 'URL_LAUNCHER_URL=http://<odoo server>:<odoo port, ex. 8069>' -e 'URL_LAUNCHER_WIDTH=<screen width, ex. 1024>' -e 'URL_LAUNCHER_HEIGHT=<screen height, ex. 600>' -e 'URL_LAUNCHER_TOUCH=<1 if there is a touch screen>'`. At some point, you will be asked to provide a name for the application/container, any name will be ok.
6. Download this repository and its submodules (be patient, it will take some time): `cd ..; git clone --recursive https://github.com/comodoo/resin-rpi3-odoo-posboxless.git; cd resin-rpi3-odoo-posboxless`
7. Install this container into the Raspberrypi3 (this step will take some time too): `sudo resin local push resin.local -s .`
8. Connect barcode scanner, printer and other external devices to the Raspberrypi3
9. Reboot the Raspberrypi3

**WARNING:** Odoo does not require the posboxless and the web client (in this case, electronjs) to run in the same host, you can configure the client in such a way that the barcode scanner, printer, etc. are connected to another computer which is running the posboxless. However, to make this configuration works, the computer running the posboxless also has to run Postgres. We are not covering this case at this moment, so install both in the same board.
