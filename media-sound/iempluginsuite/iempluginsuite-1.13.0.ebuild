# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake

DESCRIPTION="The IEM Plug-in Suite is a free and Open-Source audio plug-in suite."
HOMEPAGE="https://git.iem.at/audioplugins/IEMPluginSuite"
SRC_URI="https://git.iem.at/audioplugins/IEMPluginSuite/-/archive/v${PV}/IEMPluginSuite-v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="vst2 vst3 standalone jack"
REQUIRED_USE="
	jack? ( standalone )
"
DEPEND="sci-libs/fftw"
RDEPEND="${DEPEND}"
BDEPEND=""
S="${WORKDIR}/IEMPluginSuite-v${PV}"

src_prepare() {
	cmake_src_prepare
}
src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package vst2 VST2)
		$(cmake_use_find_package vst3 VST3)
		$(cmake_use_find_package standalone STANDALONE)
	)
	if use jack; then
		mycmakeargs+=( -DIEM_STANDALONE_JACK_SUPPORT=ON )
	else
		mycmakeargs+=( -DIEM_STANDALONE_JACK_SUPPORT=OFF )
	fi
	cmake_src_configure
}
