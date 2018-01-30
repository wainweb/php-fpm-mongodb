FROM php:7.2.1-fpm

LABEL maintainer "Zach Njoroge <zach@wainweb.com>"

RUN apt-get update
RUN apt-get install -y autoconf pkg-config libssl-dev
RUN pecl channel-update pecl.php.net
RUN pecl install mongodb
RUN echo "extension=mongodb.so" >> /usr/local/etc/php/conf.d/mongodb.ini
