# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    mysql_setup.sql                                    :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: egillesp <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/29 16:21:31 by egillesp          #+#    #+#              #
#    Updated: 2021/01/29 16:21:41 by egillesp         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

CREATE DATABASE wordpress;

GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost';

FLUSH PRIVILEGES;

update mysql.user set plugin = 'mysql_native_password' where user='root';
