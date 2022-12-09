FROM ubuntu:20.04

# Packages
ARG TZ=Europe/Prague
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && \
    apt-get -y install curl dnsutils git jq software-properties-common unzip vim wget zip graphviz && \
    rm -rf /var/lib/apt/lists/*
RUN add-apt-repository ppa:ondrej/php
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get update
RUN apt-get -y upgrade

# Databases
RUN apt-get -y install mysql-server

# PHP
RUN apt-get -y install php8.2 php8.2-bcmath php8.2-bz2 php8.2-cli php8.2-cgi php8.2-common php8.2-curl php8.2-gd php8.2-imap php8.2-intl php8.2-mbstring php8.2-mysql php8.2-opcache php8.2-pgsql php8.2-readline php8.2-sqlite3 php8.2-xml php8.2-zip
RUN apt-get -y install php8.2-imagick php8.2-mailparse php8.2-redis php8.2-xdebug php8.2-uuid

# Composer
RUN wget https://getcomposer.org/installer -O /tmp/composer-installer
RUN php /tmp/composer-installer
RUN chmod +x composer.phar
RUN mv composer.phar /usr/local/bin/composer

# AWS CLI
RUN apt-get -y install python3-pip
RUN pip3 install awscli
RUN curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb" \
    && dpkg -i session-manager-plugin.deb || apt-get -f -y install

# Serverless
RUN apt-get -y install nodejs yarn
RUN yarn global add serverless

# Angular
RUN yarn global add @angular/cli@13

# Sass
RUN yarn global add sass

# Symfony
RUN wget https://get.symfony.com/cli/installer -O - | bash
RUN mv $HOME/.symfony/bin/symfony /usr/local/bin/symfony || mv $HOME/.symfony5/bin/symfony /usr/local/bin/symfony

# Phive
RUN wget -O phive.phar https://phar.io/releases/phive.phar && \
    wget -O phive.phar.asc https://phar.io/releases/phive.phar.asc && \
    gpg --keyserver hkps://keys.openpgp.org --recv-keys 0x9D8A98B29B2D5D79 && \
    gpg --verify phive.phar.asc phive.phar && \
    chmod +x phive.phar && \
    mv phive.phar /usr/local/bin/phive
