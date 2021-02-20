# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: CWatcher <cwatcher@student.21-school.ru>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/19 19:26:03 by CWatcher          #+#    #+#              #
#    Updated: 2021/02/20 16:18:00 by CWatcher         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster
RUN apt update
RUN apt install -y nginx
RUN apt install -y openssl

# Tools
RUN apt install -y vim
RUN apt install -y procps
RUN apt install -y man
COPY srcs/.bashrc /root/
COPY srcs/.bash_aliases /root/

#RUN apt install -y default-mysql-server
#RUN apt install -y wordpress

WORKDIR /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 36524 -newkey rsa:2048 \
	-keyout localhost.key -out localhost.crt -subj "/C=RU/L=Moscow/O=21 School/CN=localhost"
COPY srcs/localhost.conf /etc/nginx/conf.d/
CMD ["nginx", "-g", "daemon off;"]
EXPOSE 80 443

WORKDIR /etc/nginx