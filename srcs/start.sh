# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    start.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: egillesp <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/01/19 15:46:17 by egillesp          #+#    #+#              #
#    Updated: 2021/01/29 16:22:21 by egillesp         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

if [ "$AUTOINDEX" = "OFF" ]
then
	chmod +w /etc/nginx/sites-available/localhost
	sed -i 's/autoindex on;/autoindex off;/g' /etc/nginx/sites-available/localhost
fi

service php7.3-fpm start
service nginx restart
service mysql restart



while true;
	do sleep 10000;
done
