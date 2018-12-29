FROM php:7.1

# disable interactive functions
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get -y --no-install-recommends install libmcrypt-dev libreadline-dev zlib1g-dev libxml2-dev apt-utils mysql-client curl git && \
    rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install \
    mbstring \
    mcrypt \
    zip \
    pdo_mysql \
    mysqli \
    xml

# Install PHP Code Sniffer
RUN curl -L https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar -o phpcs && \
    curl -L https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar -o phpcbf && \
    chmod a+x phpcs && \
    chmod a+x phpcbf && \
    mv phpcs /usr/local/bin/phpcs && \
    mv phpcbf /usr/local/bin/phpcbf

# Install PHP Copy Paste Detecttor
RUN curl -L https://phar.phpunit.de/phpcpd.phar -o phpcpd.phar && \
    chmod +x phpcpd.phar && \
    mv phpcpd.phar /usr/local/bin/phpcpd

# Install PHP Dead Code Detector
RUN curl -L https://phar.phpunit.de/phpdcd.phar -o phpdcd.phar && \
    chmod +x phpdcd.phar && \
    mv phpdcd.phar /usr/local/bin/phpdcd

# Install WordPress-Coding-Standards sniff
RUN mkdir -p /opt/phpcs/snifss/ && \
    cd /opt/phpcs/snifss/ && \
    git clone -b master https://github.com/WordPress-Coding-Standards/WordPress-Coding-Standards.git wpcs && \
    phpcs --config-set installed_paths /opt/phpcs/snifss/wpcs/

# Install PHP Security Checker
RUN curl -L http://get.sensiolabs.org/security-checker.phar -o security-checker.phar && \
    chmod +x security-checker.phar && \
    mv security-checker.phar /usr/local/bin/security-checker

# Install JQ to parse json on commandline
RUN curl -L https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 -o jq && \
    chmod +x jq && \
    mv jq /usr/local/bin/jq

# Install Composer
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer

# Install PHP Assumptions
RUN composer require --dev rskuipers/php-assumptions

# Install PhpMetrics
RUN curl -OL https://github.com/phpmetrics/PhpMetrics/releases/download/v2.3.2/phpmetrics.phar && \
    chmod +x phpmetrics.phar && mv phpmetrics.phar /usr/local/bin/phpmetrics

RUN apt-get update && \
    apt-get -y --no-install-recommends install parallel && \
    rm -rf /var/lib/apt/lists/*

RUN composer global require --dev psecio/parse

RUN cd /root && composer create-project thecodingmachine/washingmachine --stability=dev && cd -

RUN pecl install xdebug && \
    docker-php-ext-enable xdebug

# Install phpcs-security-audit v2 sniffes
RUN mkdir -p /opt/phpcs/snifss/ && \
    cd /opt/phpcs/snifss/ && \
    git clone -b master https://github.com/FloeDesignTechnologies/phpcs-security-audit.git phpcs-security-audit && \
    phpcs --config-set installed_paths /opt/phpcs/snifss/phpcs-security-audit/

# Install PHP-Var-Dump-Check
RUN composer global require --dev jakub-onderka/php-var-dump-check

# Install PHP-Parallel-Lint
RUN composer global require --dev jakub-onderka/php-parallel-lint

# Install Magic Number detecter
RUN cd /root && composer require povils/phpmnd && cd -
