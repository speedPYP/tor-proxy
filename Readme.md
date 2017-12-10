# Usage
for a tor http proxy listening on 192.168.0.64:3128 and a socks proxy listening on 192.168.0.64:9050
Configure browser network parameters with http proxy for all protocols
Configure proxychains network parameter with socks5 proxy

# Build image
docker build -t user/tor-proxy:1.0 .

# Launch
docker run -it -d --restart unless-stopped --publish 192.168.0.64:3128:38123 --publish 192.168.0.64:9050:39050 user/tor-proxy:1.0 --name tor-proxy

