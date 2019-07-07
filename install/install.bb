#!/usr/bin/env bash
set -e;declare -a apps=("tar" "base64");for app in ${apps[@]}; do hash $app 2>/dev/null || { echo "$app is not installed on this system"; exit 1; }; done;export _localdir="$(pwd)";export _tmpdir="/tmp/bashball-$$";export _name="$(basename $0)";source() {    lib="$1";    cd "$_tmpdir";    . "$lib";    cd "$_localdir";};export -f source;trap "rm -rf $_tmpdir" EXIT;mkdir -p $_tmpdir;printf $'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' | base64 -d | tar xz -C $_tmpdir --warning=no-timestamp;bash -c "$(cat <(echo 'cd $_localdir') $_tmpdir/main.sh)" $_name ${@};