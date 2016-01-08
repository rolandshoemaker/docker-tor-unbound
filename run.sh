#!/bin/bash
tor -f /etc/tor/torrc &
proxychains unbound -d -v
