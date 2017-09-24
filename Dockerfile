FROM comodoo/resin-rpi3-postgres:9.4

WORKDIR /posboxless

RUN set -x \
    && apt-get update \
    && buildDeps=' \
        g++ \
        gcc \
        libfreetype6-dev \
        libjpeg-dev \
        liblcms2-dev \
        libtiff5-dev \
        libwebp-dev \
        libxslt-dev \
        python-dev \
        python-imaging \
        python-tk \
        tcl8.5-dev \
        tk8.5-dev \
        zlib1g-dev \
    ' \
    && apt-get install -y $buildDeps --no-install-recommends \
    && apt-get download libpq-dev \
    && dpkg --force-all -i *.deb \
    && rm -rf /var/lib/apt/lists/* \
    && ln -s /usr/lib/x86_64-linux-gnu/libjpeg.so /usr/lib

COPY ./get-pip.py /posboxless
COPY ./requirements.txt /posboxless
RUN python get-pip.py && pip install -r requirements.txt

COPY ./odoo/addons /posboxless/addons
COPY ./odoo/odoo /posboxless/odoo
COPY ./odoo/odoo-bin /posboxless
COPY ./odoo-entrypoint.sh /posboxless

RUN mkdir -p /var/lib/odoo && chown -R postgres:postgres /var/lib/odoo

RUN usermod -a -G lp postgres

USER postgres

CMD ["./odoo-entrypoint.sh"]
