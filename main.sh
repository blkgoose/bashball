#!/bin/bash

source "optparse/optparse.sh"

optparse_usage_header="[option...] file..."
optparse.define short=d long=decompile variable=decomp desc="bashball to decompile"    default=""
optparse.define short=v long=version   variable=vers   desc="display bashball version" flag
. <(optparse.build)

set -euo pipefail

tmpdir="/tmp/bashball-$$"
mkdir -p "$tmpdir"
trap 'rm -rf $tmpdir' EXIT

# create base bashball template
cat > "$tmpdir/ball" <<'EOF'
#!/usr/bin/env bash

# check if apps are installed
set -e
declare -a apps=("tar" "base64")
for app in ${apps[@]}; do hash $app 2>/dev/null || { echo "$app is not installed on this system"; exit 1; }; done

# useful variables (can be used in scripts)
export _localdir="$(pwd)"
export _tmpdir="/tmp/bashball-$$"
export _name="$(basename $0)"

# makes source function local
source() {
    lib="$1"

    cd "$_tmpdir"
    . "$lib"
    cd "$_localdir"
}
export -f source

# trap exit and delete temporary folder
trap "rm -rf $_tmpdir" EXIT

# makes temporary folder
mkdir -p $_tmpdir

# __TAR will be replaced with the base64 tarball content
# this extracts the content of the tarball and puts it in the temporary folder
printf $'
__TAR
' | base64 -d | tar xz -C $_tmpdir --warning=no-timestamp

# executes main
bash -c "$(cat <(echo 'cd $_localdir') $_tmpdir/main.sh)" $_name ${@}
EOF

# check that required apps are present on system
declare -a apps=("tar" "base64" "ed" "sed" "tr")
for app in ${apps[@]}; do
    hash $app 2>/dev/null || {
        echo "ERROR: [$app] is missing from system" >&2
        exit 1
    }
done

function check_output {
    [ -t 1 ] && {
        echo "ERROR: refusing to output to terminal" >&2
        exit 1
    }
}

function bb_build {
    local files="${@}"

    [[ -z ${@:-} ]] && usage

    check_output || true

    has_main=false
    for f in $files; do
        [[ $f == "main.sh" ]] && has_main=true
    done

    $has_main || {
        echo "ERROR: cannot create bashball without main.sh" >&2
        exit 1
    }

    tar -czf - $files | base64 | tr '\n' '\r' | sed 's \r  g' > "$tmpdir/tar"

    printf '%s\n' "/^__TAR/r $tmpdir/tar" w | ed "$tmpdir/ball" 1>/dev/null 2>&1

    cat "$tmpdir/ball" |\
    tr '\n' '\r' |\
    sed -e 's/\r__TAR\r//' -e 's/=\r/=/' -e "s/\r'/\'/g" |\
    tr '\r' '\n' |\
    sed -e '/^\s*#[^!].*/d' -e 's/\s*#[^!].*//g' -e '/^\s*$/d' |\
    tr '\n' ';' |\
    sed 's/{;/{/g' |\
    sed 's/;/\n/'
}

function bb_dec {
    local target="$1"

    check_output || true

    grep -oP "(?<=printf \\$').*?(?=')" "$target" |\
    base64 -d
}

# version
$vers && {
    echo "bashball, version <VERSION>"
    exit 0
}

# decompression
[[ -n ${decomp:-} ]] && {
    bb_dec "$decomp"

    exit 0
}

# if nothing is specified,
# do standard bashball compression

bb_build ${@}
