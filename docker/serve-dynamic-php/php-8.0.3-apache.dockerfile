FROM php:8.0.3-apache

# Install applications (libzip)
RUN apt-get update && apt-get install -y \
	libzip-dev \
&& rm -rf /var/lib/apt/lists/*

# Install php extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql zip

# Change document root
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Activate and deactivate some apache modules
RUN a2enmod rewrite && \
    a2enmod headers && \
    a2dismod status

# Use the default production configuration
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" && \
    sed -i "s/expose_php = .*/expose_php = Off/" "$PHP_INI_DIR/php.ini" && \
    sed -i "s/^ServerTokens .*/ServerTokens Prod/" "/etc/apache2/conf-available/security.conf" && \
    sed -i "s/^ServerSignature .*/ServerSignature Off/" "/etc/apache2/conf-available/security.conf"

