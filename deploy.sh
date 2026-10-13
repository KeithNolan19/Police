#!/usr/bin/env bash
# Installs or updates PoloPace on this server at https://polo.vibedev.ie
# Usage (as root on the droplet):
#   curl -fsSL https://raw.githubusercontent.com/KeithNolan19/police/main/deploy.sh | bash
set -euo pipefail
DOMAIN="${DOMAIN:-polo.vibedev.ie}"
DIR=/var/www/polopace
mkdir -p "$DIR"
curl -fsSL https://raw.githubusercontent.com/KeithNolan19/police/main/index.html -o "$DIR/index.html"
if [ ! -f /etc/nginx/sites-available/polopace ]; then
cat > /etc/nginx/sites-available/polopace <<CONF
server {
    listen 80;
    listen [::]:80;
    server_name $DOMAIN;
    root $DIR;
    index index.html;
}
CONF
ln -sf /etc/nginx/sites-available/polopace /etc/nginx/sites-enabled/polopace
fi
nginx -t && systemctl reload nginx
echo "PoloPace deployed to http://$DOMAIN"
echo "For HTTPS (needed for screen wake lock): certbot --nginx -d $DOMAIN"
