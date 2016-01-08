FROM ubuntu:15.04

RUN \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y unbound tor tor-geoipdb proxychains && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

ADD run.sh /
ADD torrc.default /etc/tor/torrc
ADD unbound-conf.default /etc/unbound/unbound.conf
ADD http://ftp.internic.net/domain/named.cache /etc/unbound/root.hints
RUN chmod a+r /etc/unbound/root.hints
RUN chmod +x /run.sh
RUN chown root /var/lib/tor
ENV TORSOCKS_CONF_FILE=/etc/tor/torsocks.conf

EXPOSE 9053

ENTRYPOINT ["/run.sh"]