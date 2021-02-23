# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: CWatcher <cwatcher@student.21-school.ru>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/19 19:26:03 by CWatcher          #+#    #+#              #
#    Updated: 2021/02/23 17:39:55 by CWatcher         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster
RUN apt update
RUN apt install -y nginx
RUN apt install -y php-fpm
RUN apt install -y php
#RUN apt install -y openssl

# Tools
RUN apt install -y vim
RUN apt install -y procps
RUN apt install -y man
RUN apt install -y tldr
RUN apt install -y mc
COPY srcs/.bashrc /root/
COPY srcs/.bash_aliases /root/

RUN apt install ssl-cert
COPY srcs/default.conf /etc/nginx/sites-available/default
RUN apt install -y default-mysql-server
RUN echo 'deb http://deb.debian.org/debian buster-backports main' >> /etc/apt/sources.list
RUN apt update
RUN apt install -y php-twig/buster-backports
RUN export DEBIAN_FRONTEND=noninteractive && apt install -y phpmyadmin
#RUN apt install -y wordpress
#RUN ln -s /usr/share/wordpress /var/www/html/wp
COPY srcs/info.php /var/www/html

#WORKDIR /etc/nginx/ssl
#RUN openssl req -x509 -nodes -days 36524 -newkey rsa:2048 \
#	-keyout localhost.key -out localhost.crt -subj "/C=RU/L=Moscow/O=21 School/CN=localhost"
#COPY srcs/localhost.conf /etc/nginx/conf.d/
#COPY srcs/tst.conf /etc/nginx/conf.d/
CMD service mysql start && service php7.3-fpm start && nginx -g "daemon off;"
#ENTRYPOINT service php7.3-fpm start && nginx -g "daemon off;"
#CMD nginx -g "daemon off;"
EXPOSE 80 443

#WORKDIR /etc/nginx