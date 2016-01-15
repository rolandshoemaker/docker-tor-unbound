#!/bin/bash
# iptables -t filter -p udp --dport 53 --insert OUTPUT -j D
tor -f /etc/tor/torrc &
proxychains unbound -d -v
