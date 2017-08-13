FROM resin/raspberrypi3-debian:jessie

WORKDIR /posboxless

RUN set -x \
    && apt-get update \
    && buildDeps=' \
        g++ \
        gcc \
        libfreetype6-dev \
        libjpeg-dev \
        liblcms2-dev \
        libpq-dev \
        libtiff5-dev \
        libwebp-dev \
        libxslt-dev \
        python2.7 \
        python-dev \
        python-imaging \
        python-pip \
        python-tk \
        tcl8.5-dev \
        tk8.5-dev \
        zlib1g-dev \
    ' \
    && apt-get install -y $buildDeps --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && ln -s /usr/lib/x86_64-linux-gnu/libjpeg.so /usr/lib

COPY ./requirements.txt /posboxless
RUN pip install -r requirements.txt

COPY ./odoo/addons /posboxless/addons
COPY ./odoo/odoo /posboxless/odoo
COPY ./odoo/odoo-bin /posboxless

CMD ["./odoo-bin", "--load=hw_proxy,hw_scale,hw_scanner,hw_escpos"]
