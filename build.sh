#!/bin/sh -e

ROOT=$(cd "$(dirname "$0")"; pwd -P)

CHROOT=$ROOT/chroot/root
CHROOT_CONF=$CHROOT/root/etc/pacman.conf
REPO=/var/local/repo
REPODB=/var/local/repo/custom.db.tar.gz

mkdir -p $CHROOT

[ -d $CHROOT/root ] || mkarchroot $CHROOT/root base-devel git
if ! [ -e $REPODB ]; then
	sudo mkdir -p $REPO
	sudo repo-add $REPODB
fi

mkdir -p ~/.gnupg
echo 'keyserver-options auto-key-retrieve' > ~/.gnupg/gpg.conf

if ! grep -q $REPO $CHROOT_CONF; then
	sudo tee -a $CHROOT_CONF <<-EOF
	[custom]
	SigLevel = Optional TrustAll
	Server = file:///var/local/repo
	EOF
fi


pkgver() {
	local d=$1
	local v=$(awk -F= '/^pkgver=/ { print $2 }' $d/PKGBUILD)
	local r=$(awk -F= '/^pkgrel=/ { print $2 }' $d/PKGBUILD)
	local e=$(awk -F= '/^epoch=/ { print $2 }' $d/PKGBUILD)

	if [ "$e" ]; then
		e=$e:
	fi

	echo ${e}${v}-${r}-*.pkg.tar.*
}

pkgsplitnames() {
	local d=$1
	awk -F= '/^pkgname=/ { gsub(/[()]/, ""); print $2 }' $d/PKGBUILD
}

pkgadd() {
	local d=$1
	local p=$2

	[ -e $d/$p ] || continue

	sudo cp $d/$p $REPO/
	sudo repo-add $REPODB $REPO/$p
	rm $d/$p
}

arch-nspawn $CHROOT/root --bind-ro=$REPO pacman -Syu --noconfirm

for f in $ROOT/*/PKGBUILD $ROOT/../priv-pkgs/*/PKGBUILD; do
	d=$(dirname $f)
	n=$(basename $d)
	pv=$(pkgver $d)
	base_pkgf=$n-$pv

	if [ -e $REPO/$base_pkgf ]; then
		continue
	fi

	(
		cd $d
		case $n in
			*)
				makechrootpkg -c -D $REPO -r $CHROOT || :
				;;
		esac
	)


	if grep -q ^pkgbase= $f; then
		for s in $(pkgsplitnames $d); do
			pkgadd $d $s-$pv
		done
	else
		pkgadd $d $base_pkgf
	fi
done
