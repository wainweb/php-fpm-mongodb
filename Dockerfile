FROM php:7.2.5-fpm

LABEL maintainer "Zach Njoroge <zach@wainweb.com>"

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libmcrypt-dev \
        autoconf \
        pkg-config \
        libssl1.0-dev \
        fonts-takao-mincho \
        ttf-wqy-microhei \
        ttf-wqy-zenhei \
        libxrender1 \
        libfontconfig \
        xfonts-utils \
        cabextract \
        libxext6 \
        wget \
        libzip-dev \
        zip \
    && docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-install zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd 
RUN pecl channel-update pecl.php.net \
    && pecl install mongodb \
    && pecl install mcrypt-1.0.1 \
    && docker-php-ext-enable mongodb \
    && docker-php-ext-enable mcrypt
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN wget -q http://ftp.de.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.6_all.deb \
    && dpkg -i ttf-mscorefonts-installer_3.6_all.deb
RUN wget -q https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz \
    && tar xf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz \
    && cp wkhtmltox/bin/wk* /usr/local/bin/
