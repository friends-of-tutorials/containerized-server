FROM php:8.0.3-cli

# Working dir
WORKDIR /var/www/html

# Use the default production configuration
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Install applications
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    git \
    libzip-dev \
    libicu-dev \
    zip \
    unzip \
    cron \
    default-mysql-client \
    vim \
&& rm -rf /var/lib/apt/lists/*

# Install php extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql zip intl opcache

# Add opcache.ini
COPY conf.d/opcache.ini /usr/local/etc/php/conf.d/opcache.ini

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install symfony cli
RUN wget https://get.symfony.com/cli/installer -O - | bash

# Install symfony cli globally
RUN mv /root/.symfony/bin/symfony /usr/local/bin/.

