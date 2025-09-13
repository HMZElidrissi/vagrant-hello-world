#!/bin/bash

echo "=== Starting Web Server Provisioning ==="

# Update system
apt-get update -y

# Install Nginx
apt-get install -y nginx

# Start and enable Nginx
systemctl start nginx
systemctl enable nginx

# Get network info
PUBLIC_IP=$(hostname -I | awk '{print $1}')
PRIVATE_IP=$(hostname -I | awk '{print $2}')

# Create enhanced test page
cat > /var/www/html/index.html << EOF
<!DOCTYPE html>
<html>
<head>
    <title>DevOps Web Server - Step 4</title>
    <style>
        body { font-family: Arial; margin: 40px; }
        .container { max-width: 800px; margin: 0 auto; }
        h1 { color: #2c3e50; text-align: center; }
        .info { background: #ecf0f1; padding: 20px; border-radius: 5px; margin: 10px 0; }
        .network { background: #e8f5e8; padding: 15px; border-radius: 5px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Web Server Running!</h1>
        <div class="info">
            <h3>Server Status: Active</h3>
            <p><strong>OS:</strong> Ubuntu 22.04</p>
            <p><strong>Web Server:</strong> Nginx</p>
        </div>
        <div class="network">
            <h3>Network Configuration</h3>
            <p><strong>Public IP:</strong> $PUBLIC_IP</p>
            <p><strong>Private IP:</strong> $PRIVATE_IP (192.168.56.10)</p>
            <p><strong>Status:</strong> Ready for DB connection</p>
        </div>
    </div>
</body>
</html>
EOF

echo "=== Network Configuration ==="
echo "Public IP: $PUBLIC_IP"
echo "Private IP: $PRIVATE_IP"
echo "=== Web Server Provisioning Complete ==="