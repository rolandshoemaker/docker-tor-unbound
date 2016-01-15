FROM ubuntu:15.04

# Install deps
RUN \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y unbound tor tor-geoipdb proxychains iptables && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

# Add config files etc
ADD run.sh /
ADD torrc.default /etc/tor/torrc
ADD unbound-conf.default /etc/unbound/unbound.conf
ADD https://www.internic.net/domain/named.cache /etc/unbound/root.hints

# Cleanup permissions
RUN chmod a+r /etc/unbound/root.hints
RUN chmod +x /run.sh
RUN chown root /var/lib/tor

EXPOSE 9053
ENTRYPOINT ["/run.sh"]
