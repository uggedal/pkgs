#!/bin/sh -e

ROOT=$(cd "$(dirname "$0")"; pwd -P)
AUR_URL='https://aur.archlinux.org/cgit/aur.git/snapshot'
AUR_PACKAGES='
	azure-cli
	inadyn-fork
	mako-git
	needrestart
	python-j2cli
	python-tasklib
	teams
	vim-eunuch-git
	vim-lastplace
	vim-selenized-git
	vim-vimwiki
	wlsunset
'

. $ROOT/../priv-pkgs/aur.sh

fetch() {
	curl $AUR_URL/$2.tar.gz | tar -C $1 -xz
	rm -f $1/$2/.SRCINFO
	rm -f $1/$2/.gitignore
}

for p in $AUR_PACKAGES; do
	fetch $ROOT $p
done

for p in $PRIV_AUR_PACKAGES; do
	fetch $ROOT/../priv-pkgs $p
done

# Check -git packages for updates:
for d in $ROOT/*-git $ROOT/../priv-pkgs/*-git; do
	case "$d" in
		*\**)
			continue
			;;
	esac
	(
		cd $d
		GIT_CONFIG_NOSYSTEM=1 makepkg --nodeps --noprepare --nobuild
	)
done
