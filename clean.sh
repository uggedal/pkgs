#!/bin/sh

ROOT=$(cd "$(dirname "$0")"; pwd -P)

REPO=/var/local/repo
REPODB=/var/local/repo/custom.db.tar.gz

repofiles() {
	for f in  $REPO/*.pkg.tar.*; do basename $f; done | sort
}

dbfiles() {
	bsdtar -xOf $REPODB | awk '/^%FILENAME%/{getline;print}' | sort
}

for f in $(comm -23 <(repofiles) <(dbfiles)); do
	sudo rm -v $REPO/$f
done

for f in $ROOT/*/*.log $ROOT/../priv-pkgs/*/*.log; do
	if [ -e "$f" ]; then
		rm -v "$f"
	fi
done
