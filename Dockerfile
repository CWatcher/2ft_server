# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: CWatcher <cwatcher@student.21-school.ru>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/19 19:26:03 by CWatcher          #+#    #+#              #
#    Updated: 2021/02/19 20:51:58 by CWatcher         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster
RUN apt update
RUN apt install -y nginx
RUN apt install -y openssl
RUN apt install -y default-mysql-server

RUN apt install -y vim
RUN apt install -y procps
RUN apt install -y man
COPY .bashrc .

#RUN apt install -y wordpress
WORKDIR /etc/nginx/conf.d
RUN openssl req -x509 -nodes -days 36524 -newkey rsa:2048 \
	-keyout selfsigned.key -out selfsigned.crt -subj "/C=RU/L=Moscow/O=21 School/CN=localhost"

CMD ["nginx", "-g", "daemon off;"]
EXPOSE 80 443

WORKDIR /cntr