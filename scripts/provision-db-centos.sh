#!/bin/bash

echo "=== Starting Database Server Provisioning ==="

# Update system
dnf update -y

# Install MySQL
dnf install -y mysql-server mysql

# Start and enable MySQL
systemctl start mysqld
systemctl enable mysqld

# Basic MySQL setup (no password yet)
mysql -u root << 'EOF'
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;
EOF

# Create demo database and user
mysql -u root << 'EOF'
CREATE DATABASE demo_db;
CREATE USER 'demo_user'@'%' IDENTIFIED BY 'DemoPass123!';
GRANT ALL PRIVILEGES ON demo_db.* TO 'demo_user'@'%';
FLUSH PRIVILEGES;
EOF

echo "=== Database Server Info ==="
echo "MySQL Status: $(systemctl is-active mysqld)"
echo "Database: demo_db"
echo "User: demo_user"
echo "=== Database Server Provisioning Complete ==="