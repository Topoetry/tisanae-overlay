# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A modern and transparent way to use Windows VST2 and VST3 plugins on Linux "
HOMEPAGE="https://github.com/robbert-vdh/yabridge"
SRC_URI="https://github.com/robbert-vdh/yabridge/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="with-bitbridge"

DEPEND=">=dev-libs/boost-1.66.0
	virtual/wine
	x11-libs/libxcb"
RDEPEND="${DEPEND}"
BDEPEND="sys-devel/gcc"
src_configure() {
	local emesonargs=(
	$(meson_use with-bitbridge)
	--cross-file=cross-wine.conf
	)
	meson_src_configure
}
src_compile() {
	meson_src_compile --cross-file=cross-wine.conf --unity=on --unity-size=1000
}
