FROM ubuntu:18.04

# Cache Bust
RUN echo 7.3.9

# Packages
RUN apt-get update
RUN apt-get -y install software-properties-common wget unzip zip
RUN add-apt-repository ppa:ondrej/php
RUN apt-get update
RUN apt-get -y upgrade

# PHP
RUN apt-get -y install php7.3 php7.3-bcmath php7.3-bz2 php7.3-cli php7.3-cgi php7.3-common php7.3-curl php7.3-gd php7.3-imap php7.3-intl php7.3-json php7.3-mbstring php7.3-mysql php7.3-opcache php7.3-pgsql php7.3-readline php7.3-sqlite3 php7.3-xml php7.3-zip
RUN apt-get -y install php-imagick php-mailparse php-redis

# Composer
RUN wget https://getcomposer.org/installer -O /tmp/composer-installer
RUN php /tmp/composer-installer
RUN chmod +x composer.phar
RUN mv composer.phar /usr/local/bin/composer
