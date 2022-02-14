# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake xdg

if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://github.com/iurie-sw/${PN}/archive/v${PV}.tar.gz  -> ${P}.tar.gz"
	KEYWORDS="~amd64"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/iurie-sw/${PN}.git"
fi

DESCRIPTION="A free software percussion synthesizer"
HOMEPAGE="https://github.com/iurie-sw/geonkick"
LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-libs/rapidjson
	media-libs/libsndfile
	media-libs/lv2
"
RDEPEND="${DEPEND}"
BDEPEND="
	>=dev-util/cmake-3.7
"

src_prepare() {
	sed -i "s/Version=1.10/Version=1.1/" "${S}/data/geonkick.desktop"
	cmake_src_prepare
}
