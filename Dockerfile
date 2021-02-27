# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: CWatcher <cwatcher@student.21-school.ru>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/19 19:26:03 by CWatcher          #+#    #+#              #
#    Updated: 2021/02/27 17:39:23 by CWatcher         ###   ########.fr        #
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
#RUN apt install -y openssl
RUN apt install ssl-cert

# Tools
RUN apt install -y vim
RUN apt install -y procps
RUN apt install -y man
RUN apt install -y manpages
RUN apt install -y tldr && tldr tldr
RUN apt install -y mc
COPY srcs/info.php /var/www/html
RUN ln -s /usr/share/doc/ /var/www/html/doc
COPY srcs/.bashrc /root/
COPY srcs/.bash_aliases /root/

# Nginx
COPY srcs/default.conf /etc/nginx/sites-available/default
COPY srcs/autoindex*.conf /etc/nginx/snippets/
WORKDIR /usr/local/sbin
COPY srcs/*autoindex*.sh .
RUN chmod +x *autoindex*.sh
WORKDIR /
#WORKDIR /etc/nginx/ssl
#RUN openssl req -x509 -nodes -days 36524 -newkey rsa:2048 \
#	-keyout localhost.key -out localhost.crt -subj "/C=RU/L=Moscow/O=21 School/CN=localhost"

# phpMyAdmin
RUN ln -s /usr/share/phpmyadmin /var/www/html/pma
#COPY /srcs/config-db.php /etc/phpmyadmin/
COPY srcs/config.inc.php /etc/phpmyadmin/
RUN service mysql start && \
	mysql -e "CREATE USER pma@localhost IDENTIFIED BY 'ft';" && \
	mysql -e "GRANT ALL PRIVILEGES ON *.* TO pma@localhost"
##	mysql -e "FLUSH PRIVILEGES"

# Wordpress
RUN ln -s /usr/share/wordpress /var/www/html/wp
COPY srcs/config-localhost.php /etc/wordpress/
RUN service mysql start && \
	mysql -e "CREATE USER wp@localhost IDENTIFIED BY 'ft'" && \
	mysql -e "GRANT ALL PRIVILEGES ON wp.* TO wp@localhost" && \
	mysql -e "CREATE DATABASE wp"

ENV AUTOINDEX=on
CMD set_autoindex.sh && service mysql start && service php7.3-fpm start && nginx -g "daemon off;"
EXPOSE 80 443