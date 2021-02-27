AUTOINDEX = on

all: Dockerfile srcs/*
	docker build -t ft .

fclean:
	docker stop ft; docker rm ft; docker rmi ft

#re: fclean all

run:
	docker run -p80:80 -p443:443 -v $(PWD):/3ft_server --name ft  -e AUTOINDEX=$(AUTOINDEX) -d ft

#rerun: re run

.PHONY: all fclean re run rerun