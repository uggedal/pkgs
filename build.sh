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


pkgf() {
	local d=$1
	local v=$(awk -F= '/^pkgver=/ { print $2 }' $d/PKGBUILD)
	local r=$(awk -F= '/^pkgrel=/ { print $2 }' $d/PKGBUILD)
	local e=$(awk -F= '/^epoch=/ { print $2 }' $d/PKGBUILD)

	if [ "$e" ]; then
		e=$e:
	fi

	echo $(basename $d)-${e}${v}-${r}-*.pkg.tar.*
}

arch-nspawn $CHROOT/root --bind-ro=$REPO pacman -Syu --noconfirm

for f in $ROOT/*/PKGBUILD; do
	d=$(dirname $f)
	n=$(basename $d)
	p=$(pkgf $d)

	if [ -e $REPO/$p ]; then
		continue
	fi

	(
		cd $d
		case $n in
			*)
				makechrootpkg -c -D $REPO -r $CHROOT
				;;
		esac
	)

	sudo cp $d/$p $REPO/
	sudo repo-add $REPODB $REPO/$p
	rm $d/$p
done
