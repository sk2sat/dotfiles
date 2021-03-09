#!/bin/bash

GIT_REPO="https://github.com/sk2sat/dotfiles"
DOTPATH=$HOME/dotfiles
PUBKEYS=("https://sksat.net/sksat.pub" "https://sksat.pub/pgp")
FINGERPRINT="A5F9 5E92 A7EF B190 A818  9609 A450 0EC5 DD16 4E44"

# check distro
if [ -e /etc/os-release ];then
	name=`cat /etc/os-release | head -n1`
	name=${name:6}
	distro=${name::-1}
else
	echo "/etc/os-release does not exist"
	exit
fi
echo "Distribution: "$distro

# package manager
function install_pkg () {
	case $distro in
		"Ubuntu") apt install -y $@ ;;
		"Arch Linux") {
			if (type yay > /dev/null 2>&1); then
				yay -S --noconfirm $@
			else
				pacman -S --noconfirm $@
			fi
		} ;;
		*) exit
	esac
}

# check dependencies
cmd_deps=("curl" "git" "make" "gpg")
pkgs=""
for d in ${cmd_deps[@]}; do
	if !(type $d > /dev/null 2>&1); then
		echo $d is not installed
		deps+=" $d"
	fi
done
echo "install packages: $deps"
install_pkg $deps

# check pubkeys
echo "pubkey fingerprint: $FINGERPRINT"
for url in $PUBKEYS; do
	echo -n "pubkey from $url: "
	p=$(curl $url 2>/dev/null)
	pubkey+=( "$p" )
	f=$(echo "$p" | gpg --show-keys --with-fingerprint | head -n2 | tail -n1)
	f=${f:6}
	echo $f
	if [ "$f" != "$FINGERPRINT" ]; then
		echo -e "\e[31mError. Human is Dead, mismatch.\e[m"
		exit -1
	fi
done
echo "$p" | gpg --import

if [ -d $DOTPATH ];then
	echo "$DOTPATH is already exists. execute update"
	cd $DOTPATH
	make update
	exit
fi

git clone $GIT_REPO $DOTPATH
cd $DOTPATH
git verify-commit HEAD
if [ $? -ne 0 ]; then
	echo -e "\e[31mError. Human is Dead, mismatch.\e[m"
	exit -1
fi

make install
