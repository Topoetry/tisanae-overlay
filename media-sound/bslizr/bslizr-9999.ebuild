# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

if [[ ${PV} != *9999* ]]; then
	MY_PN="BSlizr"
	MY_P="${MY_PN}-${PV}"
	S="${WORKDIR}/${MY_P}"
	SRC_URI="https://github.com/sjaehn/${MY_PN}/archive/${PV}.tar.gz  -> ${P}.tar.gz"
	KEYWORDS="~amd64"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sjaehn/BSlizr.git"
fi

DESCRIPTION="Sequenced audio slicing effect LV2 plugin"
HOMEPAGE="https://x42-plugins.com/x42/x42-midifilter"
LICENSE="GPL-3"
SLOT="0"
IUSE="uwu"

DEPEND="
	media-libs/lv2
	x11-libs/libX11
	x11-libs/cairo[X]
"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
"

src_compile() {
	emake STRIP="true" $(usex uwu "UWU=1" "")
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" LV2DIR="/usr/$(get_libdir)/lv2" install
}
