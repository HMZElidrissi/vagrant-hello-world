#!/bin/bash

echo "=== Starting Web Server Provisioning ==="

# Update system
apt-get update -y

# Install Nginx
apt-get install -y nginx

# Start and enable Nginx
systemctl start nginx
systemctl enable nginx

# Configure firewall
ufw allow 'Nginx Full'
ufw allow ssh
echo "y" | ufw enable

# Remove default nginx page (synced folder will provide content)
rm -f /var/www/html/index.nginx-debian.html

# Ensure correct permissions for synced folder
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

# Get network info
PUBLIC_IP=$(hostname -I | awk '{print $1}')
PRIVATE_IP=$(hostname -I | awk '{print $2}')

echo "=== Web Server Info ==="
echo "Nginx Status: $(systemctl is-active nginx)"
echo "Public IP: $PUBLIC_IP"
echo "Private IP: $PRIVATE_IP"
echo "Website content synced from host machine"
echo "=== Web Server Provisioning Complete ==="