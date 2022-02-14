# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

V_DPF="11ccb2814db15a8f2c22abc8b30b003a20d108f4"
V_COMMON="3e6e293458097d10d97eaf386ab593823942a9c1"
V_INIH="bc989ed4294bfcf9f00c8a8d57a48666568d12e5"
SRC_URI="
	https://github.com/pdesaulniers/wolf-shaper/archive/v${PV}.tar.gz  -> ${P}.tar.gz
	https://github.com/pdesaulniers/DPF/archive/${V_DPF}.tar.gz -> dpf-${V_DPF}.tar.gz
	https://github.com/pdesaulniers/wolf-common/archive/${V_COMMON}.tar.gz -> wolf-common-${V_COMMON}.tar.gz
	https://github.com/pdesaulniers/inih/archive/${V_INIH}.tar.gz -> inih-${V_INIH}.tar.gz
"
KEYWORDS="~amd64"

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

src_unpack() {
	default
	rm -rf "${S}/dpf" || die
	cp -r "${WORKDIR}/DPF-${V_DPF}" "${S}/dpf" || die
	rm -rf "${S}/plugins/wolf-shaper/Common" || die
	cp -r "${WORKDIR}/wolf-common-${V_COMMON}" "${S}/plugins/wolf-shaper/Common" || die
	rm -rf "${S}/plugins/wolf-shaper/Libs/inih" || die
	cp -r "${WORKDIR}/inih-${V_INIH}" "${S}/plugins/wolf-shaper/Libs/inih" || die
}

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
		cp "${S}/bin/${PN}-vst.so" "${D}/usr/$(get_libdir)/vst" || die "Failed to install"
	fi
	if use dssi; then
		dodir /usr/$(get_libdir)/dssi
		cp "${S}/bin/${PN}-dssi.so" "${D}/usr/$(get_libdir)/dssi" || die "Failed to install"
		cp -r "${S}/bin/${PN}-dssi" "${D}/usr/$(get_libdir)/dssi" || die "Failed to install"
	fi
	if use jack; then
		dodir /usr/bin
		dobin bin/"${PN}"
	fi
}
