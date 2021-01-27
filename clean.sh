#!/bin/sh

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
