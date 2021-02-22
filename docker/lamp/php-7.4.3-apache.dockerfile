FROM php:7.4.3-apache
#RUN echo "ServerName php-7.4.3-apache" >> /etc/apache2/apache2.conf
RUN docker-php-ext-install mysqli pdo pdo_mysql

