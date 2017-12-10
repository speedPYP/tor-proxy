############################################################
# Dockerfile to build Tor Proxy container images
# Based on Debian
############################################################

# Set the base image to Debian:Jessie
FROM debian:jessie

#File Author / Maintainer
MAINTAINER Pierre-Yves Pardoel <pierreyves.pardoel@gmail.com>


# Suppress Upstart errors/warning
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Configure Tor package source
ADD etc/apt/sources.list.d/torproject.list /etc/apt/sources.list.d/torproject.list
RUN gpg --keyserver pgp.mit.edu --recv 886DDD89
RUN gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add -

# Install packages
RUN apt-get update
RUN apt-get install -y polipo tor deb.torproject.org-keyring

# Add Tor and Polipo configuration
ADD etc/polipo/config /etc/polipo/config
ADD etc/tor/torrc /etc/tor/torrc

RUN chmod 644 /etc/polipo/config
RUN chmod 644 /etc/tor/torrc

# Expose Ports
EXPOSE 38123 39050

ENTRYPOINT service tor restart && service polipo restart && /bin/bash
