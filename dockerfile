FROM alpine:latest

# Install required packages
RUN apk add --no-cache inotify-tools curl jq bash

# Create a directory for the script
WORKDIR /app

# Copy the script into the container
COPY npm.pihole.sync.sh /app

# Make the script executable
RUN chmod +x /app/npm.pihole.sync.sh

# Run the script
CMD ["/app/npm.pihole.sync.sh"]
