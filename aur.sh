#!/bin/sh -e

ROOT=$(cd "$(dirname "$0")"; pwd -P)
AUR_URL='https://aur.archlinux.org/cgit/aur.git/snapshot'
AUR_PACKAGES='
	needrestart
'

for p in $AUR_PACKAGES; do
	curl $AUR_URL/$p.tar.gz | tar -C $ROOT -xz
	rm -f $ROOT/$p/.SRCINFO
done
