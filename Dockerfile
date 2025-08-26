FROM ubuntu:24.04

# Packages
ARG TZ=Europe/Prague

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && \
    apt-get -y install curl dnsutils git jq libmagickwand-dev libmagickcore-dev rsync software-properties-common unzip uuid-dev vim wget zip graphviz && \
    rm -rf /var/lib/apt/lists/*
RUN add-apt-repository -y ppa:ondrej/php
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" > /etc/apt/sources.list.d/nodesource.list
RUN apt-get update
RUN apt-get -y upgrade

# Databases
RUN apt-get -y install mysql-server

# PHP
RUN apt-get -y install php8.4 php8.4-bcmath php8.4-bz2 php8.4-cli php8.4-cgi php8.4-common php8.4-curl php8.4-dev  \
    php8.4-gd php8.4-imagick php8.4-imap php8.4-intl php8.4-mbstring php8.4-mysql php8.4-opcache php8.4-pgsql  \
    php8.4-readline php8.4-redis php8.4-sqlite3 php8.4-uuid php8.4-xdebug php8.4-xml php8.4-zip
RUN pecl download mailparse && \
    mkdir mailparse && \
    tar xvzf mailparse-*.tgz -C mailparse && \
    cd mailparse/mailparse* && \
    phpize && \
    ./configure && \
    sed -i 's/^\(#error .* the mbstring extension!\)/\/\/\1/' mailparse.c && \
    make && \
    make install && \
    cd ../.. && \
    rm -rf mailparse* && \
    echo "extension=mailparse.so" >> /etc/php/8.4/cli/php.ini

# Composer
RUN wget https://getcomposer.org/installer -O /tmp/composer-installer
RUN php /tmp/composer-installer
RUN chmod +x composer.phar
RUN mv composer.phar /usr/local/bin/composer

# AWS CLI
RUN apt-get -y install python3-pip
RUN pip3 install awscli --break-system-packages
RUN curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb" \
    && dpkg -i session-manager-plugin.deb || apt-get -f -y install

# Serverless
RUN apt-get -y install nodejs yarn
RUN yarn global add serverless@3

# Angular
RUN yarn global add @angular/cli@18

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
