#!/bin/bash
iptables -t filter -p udp --dport 53 --insert OUTPUT -j DROP
tor -f /etc/tor/torrc &
PROXYCHAINS_SOCKS5=9050 proxychains unbound -d -v
