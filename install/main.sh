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
    default="/bin/bashball"

. <(optparse.build)

set -euo pipefail

[[ $release == 'latest' ]] && {
    dl_link="https://github.com/blkgoose/bashball/releases/latest/download/bashball"
} || {
    dl_link="https://github.com/blkgoose/bashball/releases/download/v${release}/bashball"
}

echo "starting download for bashball:[${release}] in ${outdir}"

sudo wget ${wgetopt} ${dl_link} -O ${outdir}

case $? in
    0) echo "bashball installed correctly" ;;
    1) echo "error during download" >&2 ;;
    2) echo "error during argument parsing" >&2 ;;
    3) echo "error during write operation" >&2 ;;
    4) echo "error during network operation" >&2 ;;
    5) echo "error during ssl verification" >&2 ;;
    6) echo "error during username/password authentication" >&2 ;;
    7) echo "wget protocol error" >&2 ;;
    8) echo "release doesn't exist" >&2 ;;
esac
