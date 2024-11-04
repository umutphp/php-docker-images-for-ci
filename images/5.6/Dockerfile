FROM php:5.6.6

# disable interactive functions
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get -y --no-install-recommends install libmcrypt-dev libreadline-dev zlib1g-dev libxml2-dev apt-utils curl git zip unzip && \
    rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install \
    mbstring \
    mcrypt \
    zip \
    pdo_mysql \
    mysqli \
    xml \
    bcmath

RUN apt-get update && \
    apt-get install -y zlib1g-dev libicu-dev g++ && \
    rm -rf /var/lib/apt/lists/* && \
    docker-php-ext-configure intl && \
    docker-php-ext-install intl

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

# Install Composer
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer

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
RUN mkdir -p /tools/php-parallel-lint/php-var-dump-check && \
    cd /tools/php-parallel-lint/php-var-dump-check && \
    composer require --dev php-parallel-lint/php-var-dump-check && \
    cd -

# Install PHP-Parallel-Lint
RUN mkdir -p /tools/php-parallel-lint/php-parallel-lint && \
    cd /tools/php-parallel-lint/php-parallel-lint && \
    composer require --dev php-parallel-lint/php-parallel-lint && \
    cd -

# Install Magic Number Detecter
RUN mkdir -p /tools/povils/phpmnd && \
    cd /tools/povils/phpmnd && \
    composer require povils/phpmnd && \
    cd -

# Install PHP Assumptions
RUN mkdir -p /tools/rskuipers/php-assumptions && \
    cd /tools/rskuipers/php-assumptions && \
    composer require --dev rskuipers/php-assumptions && \
    cd -

# Add update script
ADD https://raw.githubusercontent.com/umutphp/php-docker-images-for-ci/master/scripts/update.sh /update.sh
RUN chmod +x /update.sh

# Add gitignore check script
ADD https://raw.githubusercontent.com/umutphp/php-docker-images-for-ci/master/scripts/gitignore_checker.sh /gitignore_checker.sh
RUN chmod +x /gitignore_checker.sh && ln -s /gitignore_checker.sh /usr/local/bin/gitignore_checker

# Add merge conflict checker script
ADD https://raw.githubusercontent.com/umutphp/php-docker-images-for-ci/master/scripts/merge_conflict_checker.sh /merge_conflict_checker.sh
RUN chmod +x /merge_conflict_checker.sh && ln -s /merge_conflict_checker.sh /usr/local/bin/merge_conflict_checker

# Install PHPMD
RUN mkdir -p /tools/phpmd/phpmd && \
    cd /tools/phpmd/phpmd && \
    composer require --dev phpmd/phpmd && \
    cd -

# Install local-php-security-checker
RUN mkdir -p /tools/local-php-security-checker && \
    cd /tools/local-php-security-checker && \
    curl -L https://github.com/fabpot/local-php-security-checker/releases/download/v1.0.0/local-php-security-checker_1.0.0_linux_amd64 -o local-php-security-checker && \
    chmod +x local-php-security-checker && \
    mv local-php-security-checker /usr/local/bin/local-php-security-checker

# Unset COMPOSER_BIN_DIR
ENV COMPOSER_BIN_DIR="vendor/bin"

# Unset the entry point
ENTRYPOINT []
