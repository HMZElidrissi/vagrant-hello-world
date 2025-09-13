# Vagrant Hello World

This project demonstrates Infrastructure as Code using Vagrant to deploy a multi-machine environment:

- **Web Server** (Ubuntu 22.04): Nginx serving synchronized content
- **Database Server** (CentOS 9): MySQL with demo user data
- **Private Network**: Secure inter-VM communication
- **Port Forwarding**: Database access from host machine

## Architecture

```
┌─────────────────┐    Réseau Public     ┌─────────────────┐
│   UTILISATEUR   │─────────────────────▶│   WEB SERVER    │
│                 │   (192.168.1.0/24)   │   (Ubuntu)      │
└─────────────────┘                      └─────────┬───────┘
                                                   │
                                         Réseau Privé
                                         (192.168.56.0/24)
                                                   │
                  Machine Physique                │
                  Port 3307                       │
                        ▲                         │
                        └─────────────────────────┼───────┐
                                         ┌─────────▼───────┐
                                         │  DATABASE       │
                                         │  (CentOS)       │
                                         └─────────────────┘
```

## Prerequisites
1. **VirtualBox**: https://www.virtualbox.org/wiki/Downloads
2. **Vagrant**: https://www.vagrantup.com/downloads
3. **Git**: https://git-scm.com/downloads
4. **4GB+ RAM available** for VMs

## Deployment
```bash
# Clone repository
git clone https://github.com/HMZElidrissi/vagrant-hello-world
cd vagrant-hello-world

# Start infrastructure
vagrant up

# This will:
# ✅ Create 2 VMs (Ubuntu + CentOS)
# ✅ Configure networking
# ✅ Install services (Nginx + MySQL)
# ✅ Set up demo database
# ✅ Test connectivity
```

## Access Services

### Website:

Open your browser and go to `http://192.168.3.113/`

### Database (from host machine):
```bash
mysql -h localhost -P 3307 -u demo_user -p
# Password: DemoPass123!
# Database: demo_db
```

### SSH Access:
```bash
vagrant ssh web-server    # Ubuntu web server
vagrant ssh db-server     # CentOS database server
```

