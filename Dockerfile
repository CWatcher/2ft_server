# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: CWatcher <cwatcher@student.21-school.ru>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/19 19:26:03 by CWatcher          #+#    #+#              #
#    Updated: 2021/02/27 19:55:27 by CWatcher         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster
RUN apt update
RUN apt install -y nginx
RUN apt install -y php7.3-fpm
RUN apt install -y php
RUN apt install -y default-mysql-server
RUN echo 'deb http://deb.debian.org/debian buster-backports main' >> /etc/apt/sources.list && \
	apt update
RUN apt install -y php-twig/buster-backports
RUN export DEBIAN_FRONTEND=noninteractive && \
	apt install -y phpmyadmin
RUN apt install -y wordpress
RUN apt install ssl-cert

# Nginx
COPY srcs/etc/nginx/sites-available/default.conf /etc/nginx/sites-available/default
COPY srcs/etc/nginx/snippets/autoindex*.conf /etc/nginx/snippets/
COPY srcs/usr/local/sbin/*autoindex*.sh /usr/local/sbin/
RUN chmod +x /usr/local/sbin/*autoindex*.sh

# phpMyAdmin
RUN ln -s /usr/share/phpmyadmin /var/www/html/pma
COPY srcs/etc/phpmyadmin/config.inc.php /etc/phpmyadmin/
RUN service mysql start && \
	mysql -e "CREATE USER pma@localhost IDENTIFIED BY 'ft';" && \
	mysql -e "GRANT ALL PRIVILEGES ON *.* TO pma@localhost"

# Wordpress
RUN ln -s /usr/share/wordpress /var/www/html/wp
COPY srcs/etc/wordpress/config-localhost.php /etc/wordpress/
RUN service mysql start && \
	mysql -e "CREATE USER wp@localhost IDENTIFIED BY 'ft';" && \
	mysql -e "GRANT ALL PRIVILEGES ON wp.* TO wp@localhost" && \
	mysql -e "CREATE DATABASE wp"

ENV AUTOINDEX=on
CMD set_autoindex.sh && service mysql start && service php7.3-fpm start && nginx -g "daemon off;"
EXPOSE 80 443