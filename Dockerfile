FROM ubuntu:18.04

# Cache Bust
RUN echo 7.4.0-rc4

# Packages
ARG TZ=Europe/Prague
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && \
apt-get -y install curl git software-properties-common unzip wget zip
RUN add-apt-repository ppa:ondrej/php
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update
RUN apt-get -y upgrade

# Databases
RUN apt-get -y install mysql-server

# PHP
RUN apt-get -y install php7.4 php7.4-bcmath php7.4-bz2 php7.4-cli php7.4-cgi php7.4-common php7.4-curl php7.4-gd php7.4-imap php7.4-intl php7.4-json php7.4-mbstring php7.4-mysql php7.4-opcache php7.4-pgsql php7.4-readline php7.4-sqlite3 php7.4-xml php7.4-zip
RUN apt-get -y install php-imagick php-mailparse php-redis php-xdebug

# Composer
RUN wget https://getcomposer.org/installer -O /tmp/composer-installer
RUN php /tmp/composer-installer
RUN chmod +x composer.phar
RUN mv composer.phar /usr/local/bin/composer

# AWS CLI
RUN apt-get -y install python3-pip
RUN pip3 install awscli

# Serverless
RUN apt-get -y install yarn
RUN yarn global add serverless
