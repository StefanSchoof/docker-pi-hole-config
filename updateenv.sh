IP_LOOKUP="$(ip route get 8.8.8.8 | awk '{ print $NF; exit }')" # May not work for VPN / tun0
IPv6_LOOKUP="$(ifconfig wlan0 | grep inet6 | cut -f 10 -d " " | grep '^fd00:')" # use ipv6 with the fd00 prefix, because it does not change
GATEWAY="$(ip -4 route | grep default | cut -f 3 -d " ")"

IP="${IP:-$IP_LOOKUP}" # use $IP, if set, otherwise IP_LOOKUP
IPv6="${IPv6:-$IPv6_LOOKUP}" # use $IPv6, if set, otherwise IP_LOOKUP
DNS1="${GATEWAY}"
DNS2="$(dig +noall +additional -x ${DNS1} | cut -f 6 | grep '^fd00:')" # get ipv6 of dns1
cat > .env <<EOL
IP=${IP}
IPv6=${IPv6}
DNS1=${DNS1}
DNS2=${DNS2}
EOL
