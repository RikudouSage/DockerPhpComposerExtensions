FROM ubuntu:18.04

# Cache Bust
RUN echo 7.3.11

# Packages
ARG TZ=Europe/Prague
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && \
apt-get -y install curl git software-properties-common unzip wget zip
RUN add-apt-repository ppa:ondrej/php
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get update
RUN apt-get -y upgrade

# Databases
RUN apt-get -y install mysql-server

# PHP
RUN apt-get -y install php7.3 php7.3-bcmath php7.3-bz2 php7.3-cli php7.3-cgi php7.3-common php7.3-curl php7.3-gd php7.3-imap php7.3-intl php7.3-json php7.3-mbstring php7.3-mysql php7.3-opcache php7.3-pgsql php7.3-readline php7.3-sqlite3 php7.3-xml php7.3-zip
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
RUN apt-get -y install nodejs yarn
RUN yarn global add serverless

# Sass
RUN yarn global add sass
