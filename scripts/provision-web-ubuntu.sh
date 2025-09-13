#!/bin/bash

echo "=== Starting Web Server Provisioning ==="

# Update system
apt-get update -y

# Install Nginx
apt-get install -y nginx

# Start and enable Nginx
systemctl start nginx
systemctl enable nginx

# Create simple test page
cat > /var/www/html/index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>DevOps Web Server - Step 3</title>
    <style>
        body { font-family: Arial; margin: 40px; text-align: center; }
        h1 { color: #2c3e50; }
        .info { background: #ecf0f1; padding: 20px; border-radius: 5px; }
    </style>
</head>
<body>
    <h1>Web Server Running!</h1>
    <div class="info">
        <h3>Status: Nginx Active</h3>
        <p>Ubuntu 22.04 with Nginx</p>
        <p>Provisioned via external script</p>
    </div>
</body>
</html>
EOF

echo "=== Web Server Provisioning Complete ==="