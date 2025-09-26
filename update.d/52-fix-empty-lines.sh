#!/usr/bin/env bash
set -e

for path in ./config/*.txt
do
    echo -n "Removes blank lines from a file: $path..."
    sed --follow-symlinks -i '/^\s*$/d' "$path"
    echo '[OK]'
done

exit 0
