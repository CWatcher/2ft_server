cd /etc/nginx/snippets
ln -sf autoindex-on.conf autoindex.conf
nginx -s reload
echo "autoindex set to \"$AUTOINDEX\""