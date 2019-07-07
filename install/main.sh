#!/bin/bash

source "optparse/optparse.sh"

optparse_usage_header="[option...] file..."
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

echo "bashball installed correctly"
