#!/usr/bin/env bash

echo "Mounting..."

mount -t nfs 192.168.0.200:/share/nextcloud /var/www/html
ls -la /var/www/html
echo "Running..."
/entrypoint.sh apache2-foreground
