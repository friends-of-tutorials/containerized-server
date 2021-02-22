FROM php:8.0.2-apache
#RUN echo "ServerName php-8.0.2-apache" >> /etc/apache2/apache2.conf
RUN docker-php-ext-install mysqli pdo pdo_mysql

