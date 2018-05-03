FROM php:7.2.5-fpm

LABEL maintainer "Zach Njoroge <zach@wainweb.com>"

RUN apt-get update
RUN apt-get install -y autoconf pkg-config libssl1.0-dev libxrender1 libfontconfig libxext6 wget zip
RUN cd ~ ; \
    wget -q https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz ; \
    tar vxf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz ; \
    cp wkhtmltox/bin/wk* /usr/local/bin/
RUN pecl channel-update pecl.php.net
RUN pecl install mongodb
RUN echo "extension=mongodb.so" >> /usr/local/etc/php/conf.d/mongodb.ini
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
