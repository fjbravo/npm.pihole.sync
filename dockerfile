FROM alpine:latest

# Install required packages
RUN apk add --no-cache inotify-tools curl jq bash

# Create a directory for the script
WORKDIR /usr/src/app

# Copy the script into the container
COPY npm.pihole.sync.sh .

# Make the script executable
RUN chmod +x npm.pihole.sync.sh

# Run the script
CMD ["./npm.pihole.sync.sh"]
