# created for ::darkelf overlay.
# by Simon the Sorcerer

EAPI=6

DESCRIPTION="darkelf-features for gentoo portage"
HOMEPAGE="http://homepages.uni-paderborn.de/neuron/darkelf/"
SRC_URI="http://homepages.uni-paderborn.de/neuron/gentoo/darkelf/darkelf-features-bashrc"

LICENSE="Artistic"
KEYWORDS="amd64 ~ppc ~ppc64 x86 arm arm64"
IUSE=""
SLOT="0"

S="${WORKDIR}/"

pkg_postinst() {
	if [ ! -f /etc/portage/bashrc ]; then
		cp "$DISTDIR"/darkelf-features-bashrc /etc/portage/bashrc || die
	elif ! b2sum --quiet -c <<< "2e423452045799e5f0a4fac20c183a21a97fe66797d12646a79e154681fead73ba52300e1e939c1e4d3448a4d2ea6a33c213ae44461b8dadd904537fe7132505  /etc/portage/bashrc" ; then
		eerror ERROR: A different /etc/portage/bashrc does already exist.
	fi
	if ! grep -q "DARKELF_FEATURES" /etc/portage/make.conf ; then
		echo '#DARKELF_FEATURES="postmerge_distclean"' >> /etc/portage/make.conf || die
	fi
	elog "To enable cleaning distfiles after every merged ebuild uncomment DARKELF_FEATURES=\"postmerge_distclean\" in /etc/portage/make.conf."
}

pkg_postrm() {
	cp /etc/portage/make.conf make.conf
	sed "/^#DARKELF_FEATURES=\"postmerge_distclean\"/d" make.conf > /etc/portage/make.conf
	if b2sum --quiet -c <<< "2e423452045799e5f0a4fac20c183a21a97fe66797d12646a79e154681fead73ba52300e1e939c1e4d3448a4d2ea6a33c213ae44461b8dadd904537fe7132505  /etc/portage/bashrc" ; then
		rm /etc/portage/bashrc
	else
		ewarn /etc/portage/bashrc will be kept because it was modified.
	fi
}
