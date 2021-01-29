# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: egillesp <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/15 16:59:17 by egillesp          #+#    #+#              #
#    Updated: 2021/01/15 17:39:13 by egillesp         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

LABEL maintainer="egillesp"

# UPDATE
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y install wget

# INSTALL NGINX
RUN apt-get -y install nginx

#INSTALL VIM TO ADD HTML FILES DURING TESTING
RUN apt-get -y install vim

# INSTALL MYSQL
RUN apt-get -y install mariadb-server

# INSTALL PHP
RUN apt-get -y install php7.3 php-mysql php-fpm php-cli php-mbstring

# COPY CONTENT
COPY ./srcs/start.sh /var/
COPY ./srcs/mysql_setup.sql /var/
COPY ./srcs/wordpress.sql /var/
COPY ./srcs/nginx.conf /etc/nginx/sites-available/localhost
RUN ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost

# INSTALL PHPMYADMIN
WORKDIR /var/www/html/
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.1/phpMyAdmin-4.9.1-english.tar.gz
RUN tar xf phpMyAdmin-4.9.1-english.tar.gz && rm -rf phpMyAdmin-4.9.1-english.tar.gz
RUN mv phpMyAdmin-4.9.1-english phpmyadmin
COPY ./srcs/config.inc.php phpmyadmin

# INSTALL WORDPRESS
RUN	wget https://wordpress.org/latest.tar.gz; \tar xf latest.tar.gz -C .
RUN rm -rf latest.tar.gz
RUN chmod 755 -R wordpress

# SETUP SERVER
RUN service mysql start && mysql -u root mysql < /var/mysql_setup.sql
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=75/L=Lyon/O=42/CN=egillesp' -keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.crt
RUN chown -R www-data:www-data *
RUN chmod 755 -R *

# START SERVER
CMD bash /var/start.sh

EXPOSE 80 443