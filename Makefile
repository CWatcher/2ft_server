AUTOINDEX = on

all: Dockerfile srcs/*
	docker build -t ft .

clean:
	docker stop ft; docker rm ft

fclean: clean
	docker rmi ft

#re: fclean all

run:
	docker run -p80:80 -p443:443 -v $(PWD):/2ft_server --name ft  -e AUTOINDEX=$(AUTOINDEX) -d ft

#rerun: re run

.PHONY: all clean fclean re run rerun
