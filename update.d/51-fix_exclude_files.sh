#!/usr/bin/env bash
set -e

for name in hosts ips
do
    include_file="$(readlink -f "config/include-${name}-custom.txt")"
    exclude_file="$(readlink -f "config/exclude-${name}-dist.txt")"

    echo -n "Removes items from ${exclude_file} if they exists in ${include_file}..."
    grep -Fvxf "$include_file" "$exclude_file" > "${exclude_file}.tmp" && mv "${exclude_file}.tmp" "$exclude_file"
    echo '[OK]'
done

exit 0
