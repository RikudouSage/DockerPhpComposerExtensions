FROM ubuntu:18.04

# Cache Bust
RUN echo 8.0.0-rc1-6

# Packages
ARG TZ=Europe/Prague
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && \
apt-get -y install curl git software-properties-common unzip vim wget zip
RUN add-apt-repository ppa:ondrej/php
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get update
RUN apt-get -y upgrade

# Databases
RUN apt-get -y install mysql-server

# PHP
RUN apt-get -y install php8.0 php8.0-bcmath php8.0-bz2 php8.0-cli php8.0-cgi php8.0-common php8.0-curl php8.0-gd php8.0-imap php8.0-intl php8.0-mbstring php8.0-mysql php8.0-opcache php8.0-pgsql php8.0-readline php8.0-sqlite3 php8.0-xml php8.0-zip
RUN apt-get -y install php8.0-imagick php8.0-mailparse php8.0-redis php8.0-xdebug

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

# Angular
RUN yarn global add @angular/cli

# Sass
RUN yarn global add sass

# Symfony
RUN wget https://get.symfony.com/cli/installer -O - | bash
RUN mv $HOME/.symfony/bin/symfony /usr/local/bin/symfony
