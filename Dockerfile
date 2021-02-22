# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: CWatcher <cwatcher@student.21-school.ru>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/19 19:26:03 by CWatcher          #+#    #+#              #
#    Updated: 2021/02/22 18:54:48 by CWatcher         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster
RUN apt update
RUN apt install -y nginx
RUN apt install -y php
RUN apt install -y php-fpm

COPY srcs/default.conf /etc/nginx/sites-available/default
COPY srcs/info.php /var/www/html

ENTRYPOINT service php7.3-fpm start && nginx -g "daemon off;"
EXPOSE 80 443