FROM php:7.0.33

# disable interactive functions
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get -y --no-install-recommends install libmcrypt-dev libreadline-dev zlib1g-dev libxml2-dev apt-utils mysql-client curl git zip unzip && \
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

# Install PHP Copy Paste Detector
RUN curl -L https://phar.phpunit.de/phpcpd.phar -o phpcpd.phar && \
    chmod +x phpcpd.phar && \
    mv phpcpd.phar /usr/local/bin/phpcpd

# Install PHP Dead Code Detector
RUN curl -L https://phar.phpunit.de/phpdcd.phar -o phpdcd.phar && \
    chmod +x phpdcd.phar && \
    mv phpdcd.phar /usr/local/bin/phpdcd

# Install PHP Security Checker
RUN curl -L http://get.sensiolabs.org/security-checker.phar -o security-checker.phar && \
    chmod +x security-checker.phar && \
    mv security-checker.phar /usr/local/bin/security-checker

# Install Composer
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    composer config -g repo.packagist composer https://packagist.phpcomposer.com

# Install PhpMetrics
RUN curl -OL https://github.com/phpmetrics/PhpMetrics/releases/download/v2.3.2/phpmetrics.phar && \
    chmod +x phpmetrics.phar && mv phpmetrics.phar /usr/local/bin/phpmetrics

# Create tools folder
RUN mkdir -p /tools

# Set global bin-dir for composer packages
ENV COMPOSER_BIN_DIR="/usr/local/bin"

# Install Psecio Parse
RUN mkdir -p /tools/psecio/parse && \
    cd /tools/psecio/parse && \
    composer require --dev psecio/parse && \
    cd -

# Install PHP-Var-Dump-Check
RUN mkdir -p /tools/jakub-onderka/php-var-dump-check && \
    cd /tools/jakub-onderka/php-var-dump-check && \
    composer require --dev jakub-onderka/php-var-dump-check && \
    cd -

# Install PHP-Parallel-Lint
RUN mkdir -p /tools/jakub-onderka/php-parallel-lint && \
    cd /tools/jakub-onderka/php-parallel-lint && \
    composer require --dev jakub-onderka/php-parallel-lint && \
    cd -

# Install Magic Number Detecter
RUN mkdir -p /tools/povils/phpmnd && \
    cd /tools/povils/phpmnd && \
    composer require povils/phpmnd && \
    cd -

# Install composer.json fixer
RUN mkdir -p /tools/kubawerlos/composer-json-fixer && \
    cd /tools/kubawerlos/composer-json-fixer && \
    composer require kubawerlos/composer-json-fixer && \
    cd -

# Install PHP Assumptions
RUN mkdir -p /tools/rskuipers/php-assumptions && \
    cd /tools/rskuipers/php-assumptions && \
    composer require --dev rskuipers/php-assumptions && \
    cd -

# Add update script
ADD https://raw.githubusercontent.com/umutphp/php-docker-images-for-ci/master/scripts/update.sh /update.sh
RUN chmod +x /update.sh

# Unset COMPOSER_BIN_DIR
ENV COMPOSER_BIN_DIR=""

# Unset the entry point
ENTRYPOINT []
