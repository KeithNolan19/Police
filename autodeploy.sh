#!/usr/bin/env bash
# One-time setup: the droplet checks GitHub every 2 minutes and updates PoloPace.
# Run once as root:  curl -sL raw.githubusercontent.com/KeithNolan19/police/main/autodeploy.sh | bash
set -euo pipefail
cat > /usr/local/bin/polopace-update <<'SH'
#!/bin/sh
# Download to a temp file and swap it in only if the download worked and changed.
URL=https://raw.githubusercontent.com/KeithNolan19/police/main/index.html
DEST=/var/www/polopace/index.html
TMP=$(mktemp) || exit 1
if curl -fsSL "$URL" -o "$TMP" && [ -s "$TMP" ] && ! cmp -s "$TMP" "$DEST"; then
  chmod 644 "$TMP" && mv "$TMP" "$DEST" && echo "$(date -u) updated" >> /var/log/polopace-update.log
else
  rm -f "$TMP"
fi
SH
chmod +x /usr/local/bin/polopace-update
echo '*/2 * * * * root /usr/local/bin/polopace-update' > /etc/cron.d/polopace
chmod 644 /etc/cron.d/polopace
/usr/local/bin/polopace-update
echo "Auto-deploy on: polo.vibedev.ie updates within 2 minutes of each push to GitHub."
