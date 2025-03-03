# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Set the time zone non-interactively
ENV DEBIAN_FRONTEND=noninteractive
RUN ln -fs /usr/share/zoneinfo/UTC /etc/localtime
RUN apt-get update && apt-get install -y tzdata
RUN dpkg-reconfigure --frontend noninteractive tzdata

# Install Squid and other necessary packages
RUN apt-get update && apt-get install -y squid

# Copy the Squid configuration file
COPY squid.conf /etc/squid/squid.conf

# Expose the port (optional, since Render uses the PORT environment variable)
EXPOSE ${PORT}

# Start Squid in the foreground
CMD ["squid", "-N"]
