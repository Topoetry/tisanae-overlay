# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/pdesaulniers/wolf-shaper.git"

inherit git-r3

DESCRIPTION="Waveshaper plugin w/ spline-based graph editor"
HOMEPAGE="https://pdesaulniers.github.io/wolf-shaper/"
LICENSE="GPL-3"
SLOT="0"
IUSE="+lv2 +vst2 dssi +jack"

DEPEND="
	jack? ( virtual/jack )
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	export BUILD_LV2=$(usex lv2 true false)
	export BUILD_VST2=$(usex vst2 true false)
	export BUILD_DSSI=$(usex dssi true false)
	export BUILD_JACK=$(usex jack true false)
	export SKIP_STRIPPING=true
	default
}

src_install() {
	if use lv2; then
		dodir /usr/$(get_libdir)/lv2
		cp -r "${S}/bin/${PN}.lv2" "${D}/usr/$(get_libdir)/lv2" || die "Failed to install"
	fi
	if use vst2; then
		dodir /usr/$(get_libdir)/vst
		into /usr/$(get_libdir)/vst
		dolib.so "${S}/bin/${PN}-vst.so"
	fi
	if use dssi; then
		dodir /usr/$(get_libdir)/dssi
		into /usr/$(get_libdir)/dssi
		dolib.so "${S}/bin/${PN}-dssi.so"
		cp -r "${S}/bin/${PN}-dssi" "${D}/usr/$(get_libdir)/dssi" || die "Failed to install"
	fi
	if use jack; then
		dodir /usr/bin
		dobin "${S}/bin/${PN}"
	fi
}
