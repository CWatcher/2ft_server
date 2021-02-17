FROM debian:buster
RUN apt update
RUN apt install -y	nginx default-mysql-server
CMD ["nginx", "-g", "daemon off;"]