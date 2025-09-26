#!/usr/bin/env bash
set -e

api_url='https://api.opennicproject.org/geoip/?bare&ipv=4&res=10'
conf_file=${1:-'result/opennic.lua'}

echo -n 'Update OpenNIC DNS servers...'

echo 'return {' > "$conf_file"

while read -r host; do
    if dig @"$host" example.org +time=1 +tries=1 +short >/dev/null 2>&1; then
        echo "\"$host\"," >> "$conf_file"
    fi
done < <(curl -Lsf --fail-early "$api_url")

echo '}' >> "$conf_file"

echo '[OK]'

exit 0
