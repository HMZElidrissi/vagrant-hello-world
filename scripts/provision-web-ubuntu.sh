#!/bin/bash

echo "=== Starting Web Server Provisioning ==="

# Update system
apt-get update -y

# Install Nginx, MySQL client, and Git
apt-get install -y nginx mysql-client git

# Start and enable Nginx
systemctl start nginx
systemctl enable nginx

# Configure firewall
ufw allow 'Nginx Full'
ufw allow ssh
echo "y" | ufw enable

# Remove default nginx page
rm -f /var/www/html/index.nginx-debian.html

# Clone GitHub repository 
echo "=== Cloning GitHub Website Content ==="
cd /tmp
git clone https://github.com/startbootstrap/startbootstrap-creative.git github-content 2>/dev/null || {
    echo "GitHub clone failed, using local content only"
}

# If GitHub content exists, copy to a subdirectory
if [ -d "github-content" ]; then
    mkdir -p /var/www/html/bootstrap-theme
    cp -r github-content/dist/* /var/www/html/bootstrap-theme/
    echo "GitHub content available at: /bootstrap-theme/"
fi

# Ensure correct permissions for synced folder
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

# Test database connectivity (retry logic)
echo "=== Testing Database Connectivity ==="
DB_STATUS="Failed"
USER_COUNT="Unknown"

for i in {1..30}; do
  if mysql -h 192.168.56.20 -u demo_user -p'DemoPass123!' demo_db -e "SELECT 1;" >/dev/null 2>&1; then
    echo "Database connection successful!"
    DB_STATUS="Connected"
    USER_COUNT=$(mysql -h 192.168.56.20 -u demo_user -p'DemoPass123!' demo_db -s -e "SELECT COUNT(*) FROM users;" 2>/dev/null)
    break
  else
    echo "Waiting for database... (attempt $i/30)"
    sleep 10
  fi
done

# Create a status page with all information
cat > /var/www/html/status.html << EOF
<!DOCTYPE html>
<html>
<head>
    <title>DevOps Infrastructure Status</title>
    <style>
        body { font-family: Arial; margin: 40px; }
        .container { max-width: 900px; margin: 0 auto; }
        .status-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .status-card { background: #f8f9fa; padding: 20px; border-radius: 8px; border-left: 4px solid #28a745; }
        .links { background: #e9ecef; padding: 15px; border-radius: 5px; margin: 20px 0; }
        pre { background: #2d3748; color: #e2e8f0; padding: 15px; border-radius: 5px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>DevOps Infrastructure Status</h1>
        
        <div class="status-grid">
            <div class="status-card">
                <h3>Web Server</h3>
                <p><strong>Status:</strong> $(systemctl is-active nginx)</p>
                <p><strong>OS:</strong> Ubuntu 22.04</p>
                <p><strong>Private IP:</strong> $(hostname -I | awk '{print $2}')</p>
                <p><strong>Public IP:</strong> $(hostname -I | awk '{print $1}')</p>
            </div>
            
            <div class="status-card">
                <h3>Database Server</h3>
                <p><strong>Status:</strong> ${DB_STATUS}</p>
                <p><strong>Users Count:</strong> ${USER_COUNT}</p>
                <p><strong>Database:</strong> demo_db</p>
                <p><strong>DB IP:</strong> 192.168.56.20</p>
            </div>
        </div>
        
        <div class="links">
            <h3>Available Pages</h3>
            <ul>
                <li><a href="index.html">Main Page</a> - Custom synchronized content</li>
                <li><a href="db-test.html">Database Test</a> - Connection verification</li>
                <li><a href="bootstrap-theme/">Bootstrap Theme</a> - GitHub sourced content</li>
                <li><a href="status.html">This Status Page</a></li>
            </ul>
        </div>
        
        <div class="links">
            <h3>Test Commands</h3>
            <pre>
# Database connection test
mysql -h localhost -P 3307 -u demo_user -p
# Password: DemoPass123!

# SSH to servers
vagrant ssh web-server
vagrant ssh db-server

# Check VM status
vagrant status
            </pre>
        </div>
    </div>
</body>
</html>
EOF

# Get network info
PUBLIC_IP=$(hostname -I | awk '{print $1}')
PRIVATE_IP=$(hostname -I | awk '{print $2}')

echo "=== Web Server Info ==="
echo "Nginx Status: $(systemctl is-active nginx)"
echo "Public IP: $PUBLIC_IP"
echo "Private IP: $PRIVATE_IP"
echo "Database Status: ${DB_STATUS}"
echo "Users in database: ${USER_COUNT}"
echo "GitHub content: $([ -d '/var/www/html/bootstrap-theme' ] && echo 'Available' || echo 'Not available')"
echo "=== Web Server Provisioning Complete ==="