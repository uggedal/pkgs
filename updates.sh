#!/bin/bash -e

ROOT=$(
	cd "$(dirname "$0")"
	pwd -P
)

ALL=no
if [ "$1" = "-a" ]; then
	ALL=yes
fi

_cmp() {
	local t=$1
	local n=$2
	local _latest="$3"
	local _cur="$4"

	if [ -z "$_cur" ]; then
		eval _cur=\$$(echo $n | tr '[a-z]' '[A-Z]' | sed 's/[^A-Z]//g')_V
	fi

	if [ "$_cur" != "$_latest" ]; then
		echo 'update:  ' $t $n $_cur '->' $_latest
	else
		echo 'latest:  ' $t $n $_cur
	fi
}

gh() {
	local u=$1
	local n=$2
	local _cur="$3"

	local _latest=$(
		curl -s https://api.github.com/repos/$u/$n/releases/latest |
			jq .tag_name -j |
			sed 's/^v//'
	)

	if [ "$_latest" = null ]; then
		_latest=$(
			curl -s https://api.github.com/repos/$u/$n/tags |
				jq '.[0].name' -j |
				sed 's/^v//'
		)
	fi

	_cmp gh $n "$_latest" "$_cur"
}

pypi() {
	local n=$1
	local _cur="$2"

	local _latest=$(
		curl -s https://pypi.org/pypi/$n/json |
			jq .info.version -r
	)

	_cmp py $n "$_latest" "$_cur"
}

for f in $ROOT/*/PKGBUILD $ROOT/../priv-pkgs/*/PKGBUILD; do
	if [ "$ALL" = "no" ] && ! grep -q '# Maintainer: Eivind Uggedal' $f; then
		continue
	fi

	d=$(dirname $f)
	n=$(basename $d)

	case "$n" in
	*-git)
		continue
		;;
	esac

	(
		if ! . $f; then
			echo "unable to source: $f"
			exit 1
		fi

		if [ ${#source[@]} -eq 0 ]; then
			exit 0
		fi

		src="${source[0]}"

		case "$src" in
		*github.com*)
			s=(${src//\// })
			gh ${s[2]} ${s[3]} $pkgver
			;;
		*/pypi/*)
			s=(${src//\// })
			pypi ${s[3]} $pkgver
			;;
		*/pypi.io*)
			s=(${src//\// })
			pypi ${s[5]} $pkgver
			;;
		esac
	)
done
