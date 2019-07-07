#!/bin/bash

source "optparse/optparse.sh"

optparse_usage_header="[option...]"
optparse.define\
    long=release\
    variable=release\
    desc="bashball release to install"\
    default="latest"

optparse.define\
    long=wget-opt\
    variable=wgetopt\
    desc="options for wget download"\
    default="-q --show-progress"

optparse.define\
    long=directory\
    variable=outdir\
    desc="where to install bashball"\
    default="/usr/bin/"

. <(optparse.build)

set -euo pipefail

[[ $release == 'latest' ]] && {
    dl_link="https://github.com/blkgoose/bashball/releases/latest/download/bashball"
} || {
    dl_link="https://github.com/blkgoose/bashball/releases/download/v${release}/bashball"
}

echo "starting download for bashball:[${release}] in ${outdir}"

tmpdir="/tmp/install-bb-$$/"
trap "rm -rf $tmpdir" EXIT
mkdir -p "$tmpdir"

wget ${wgetopt} ${dl_link} -O "${tmpdir}/bashball" || {
    case $? in
        1) echo "ERROR: error during download" >&2 ;;
        2) echo "ERROR: error during argument parsing" >&2 ;;
        3) echo "ERROR: error during write operation" >&2 ;;
        4) echo "ERROR: error during network operation" >&2 ;;
        5) echo "ERROR: error during ssl verification" >&2 ;;
        6) echo "ERROR: error during username/password authentication" >&2 ;;
        7) echo "ERROR: wget protocol error" >&2 ;;
        8) echo "ERROR: release doesn't exist" >&2 ;;
    esac
    exit 1
} && {
    mv "$tmpdir/bashball" "$outdir/"
    chmod +x "$outdir/bashball"

    echo "bashball installed correctly"
}
