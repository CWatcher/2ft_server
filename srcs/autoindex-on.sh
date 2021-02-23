cd /etc/nginx/snippets
unlink autoindex.conf
ln -s autoindex-on.conf autoindex.conf
nginx -s reload