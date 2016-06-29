# Usage
for a tor proxy listening on 192.168.0.64:3128
Configure browser network parameters with this proxy for all protocols

# Build image
docker build -t user/tor-proxy:v1.0 .

# Launch
docker run -it -d --restart unless-stopped --publish 192.168.0.64:3128:8123 user/tor-proxy:v1.0 --name tor-proxy

