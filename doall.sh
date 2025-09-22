#!/usr/bin/env bash
set -e

HERE="$(dirname "$(readlink -f "${0}")")"
cd "$HERE"

./update.sh

if [[ -d "./update.d" ]]; then
    for script in ./update.d/*.sh; do
        "$script"
    done
fi

./parse.sh
./process.sh
