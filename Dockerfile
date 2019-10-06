FROM ubuntu:18.04

# Cache Bust
RUN echo 7.2.22
RUN echo v1

# Packages
RUN apt-get update
RUN apt-get -y install software-properties-common wget unzip zip
RUN add-apt-repository ppa:ondrej/php
RUN apt-get update
RUN apt-get -y upgrade

# Databases
RUN apt-get -y install mysql-server

# PHP
RUN apt-get -y install php7.2 php7.2-bcmath php7.2-bz2 php7.2-cli php7.2-cgi php7.2-common php7.2-curl php7.2-gd php7.2-imap php7.2-intl php7.2-json php7.2-mbstring php7.2-mysql php7.2-opcache php7.2-pgsql php7.2-readline php7.2-sqlite3 php7.2-xml php7.2-zip
RUN apt-get -y install php-imagick php-mailparse php-redis

# Composer
RUN wget https://getcomposer.org/installer -O /tmp/composer-installer
RUN php /tmp/composer-installer
RUN chmod +x composer.phar
RUN mv composer.phar /usr/local/bin/composer
