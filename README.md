# Nginx Proxy Manager to Pi-hole Sync

This project provides a Docker container that monitors changes in the Nginx Proxy Manager `proxy_host` folder and automatically updates Pi-hole's local DNS records with the `server_name` entries found in the `.conf` files.

## Prerequisites

- Docker and Docker Compose installed on your system.
- Access to a running Pi-hole instance with API access enabled.
- Nginx Proxy Manager setup with accessible `proxy_host` configuration files.

## Configuration

Before running the Docker container, you need to set the environment variables in the `docker-compose.yml` file to match your setup:

- `PROXY_HOST_FOLDER`: The path to the Nginx Proxy Manager `proxy_host` folder on your host machine.
- `PIHOLE_IP`: The IP address of your Pi-hole server.
- `NPM_SERVER_IP`: The IP address of your Nginx Proxy Manager server.
- `PIHOLE_USER`: The username for SSH access to your Pi-hole server.
- `PIHOLE_PASS`: The password for SSH access to your Pi-hole server.
- `DRY_RUN`: set to true to execute the script, and no changes will be made in PiHole. Default to 0 (false) if not set

## Installation

1. Clone the repository to your local machine:

   ```bash
   git clone https://github.com/your-username/npm-pihole-sync.git
   cd npm-pihole-sync
