cd /etc/nginx/snippets
unlink autoindex.conf
ln -s autoindex-off.conf autoindex.conf
nginx -s reload