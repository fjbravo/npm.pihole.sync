#!/bin/bash

# Environment variables
PROXY_HOST_FOLDER=$/app/proxy_host
PIHOLE_IP=${PIHOLE_IP}
NPM_SERVER_IP=${NPM_SERVER_IP}
PIHOLE_USER=${PIHOLE_USER}
PIHOLE_PASS=${PIHOLE_PASS}
DRY_RUN=${DRY_RUN:-0} # Default to 0 (false) if not set

# Function to add DNS record to Pi-hole
add_dns_record() {
    local server_name=$1
    local ip_address=$2
    local dry_run=$3

    # Check if the record already exists
    if curl -s -L -X GET "http://${PIHOLE_IP}/admin/api_db.php?get=domains" --data "auth=${PIHOLE_PASS}" | jq -e ".data[] | select(.domain == \"${server_name}\")" > /dev/null; then
        echo "Record for ${server_name} already exists in Pi-hole."
    else
        # Add the DNS record
        if [[ "${dry_run}" -eq 0 ]]; then
            curl -s -L -X POST "http://${PIHOLE_IP}/admin/api_db.php?add=domain" --data "domain=${server_name}&ip=${ip_address}&auth=${PIHOLE_PASS}"
        fi
        echo "Added record for ${server_name} to Pi-hole."
    fi
}

# Monitor the proxy_host folder for changes
inotifywait -m -e create,modify,delete --format '%w%f' "${PROXY_HOST_FOLDER}" | while read file; do
    # Check if the file is a .conf file
    if [[ "${file}" == *.conf ]]; then
        # Extract server_name entries
        server_names=$(grep -oP 'server_name\s+\K[^;]+' "${file}")
        for name in ${server_names}; do
            add_dns_record "${name}" "${NPM_SERVER_IP}"
        done
    fi
done
