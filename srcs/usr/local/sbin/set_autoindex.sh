cd /etc/nginx/snippets
ln -sf autoindex-${AUTOINDEX}.conf autoindex.conf
#nginx -s reload
echo "Autoindex set to \"$AUTOINDEX\". To enable - reload config"