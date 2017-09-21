docker-entrypoint.sh postgres &

./odoo-bin --load=hw_proxy,hw_scale,hw_scanner,hw_escpos
