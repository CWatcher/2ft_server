cd /etc/nginx/snippets
ln -sf autoindex-off.conf autoindex.conf
nginx -s reload
echo "autoindex set to \"$AUTOINDEX\""