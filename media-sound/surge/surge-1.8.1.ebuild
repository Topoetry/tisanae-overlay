# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=7

inherit eutils git-r3

DESCRIPTION="Surge is an open source digital synthesizer"
HOMEPAGE="https://surge-synthesizer.github.io//"
EGIT_REPO_URI="https://github.com/surge-synthesizer/surge.git"
EGIT_COMMIT="release_${PV}"
LICENSE="GPL3"
SLOT="0"
IUSE="lv2 vst vst3"
KEYWORDS="amd64"
DEPEND="x11-libs/cairo
        x11-libs/libxkbcommon
        x11-libs/libxcb"
RDEPEND=${DEPEND}
PATCHES=("${FILESDIR}"/install.patch)


src_compile() {
    if use lv2; then
        ${S}/build-linux.sh -p lv2 build
    fi

    if use vst; then
        ${S}/build-linux.sh -p vst2 build
    fi

    if use vst3; then
        ${S}/build-linux.sh -p vst3 build
    fi
}

src_install() {
    dodir /usr/bin
    dodir /usr/share/surge

    if use lv2; then
        dodir /usr/$(get_libdir)/lv2

        lv2_dest_path="${D}/usr/$(get_libdir)/lv2" data_path="${D}/usr/share/surge" ${S}/build-linux.sh -p lv2 install
    fi

    if use vst; then
        dodir /usr/$(get_libdir)/vst

        vst2_dest_path="${D}/usr/$(get_libdir)/vst" data_path="${D}/usr/share/surge" ${S}/build-linux.sh -p vst2 install
    fi

    if use vst3; then
        dodir /usr/$(get_libdir)/vst3

        vst3_dest_path="${D}/usr/$(get_libdir)/vst" data_path="${D}/usr/share/surge" ${S}/build-linux.sh -p vst3 install
    fi
    # vst2_dest_path="${D}/usr/lib/vst" vst3_dest_path="${D}/usr/lib/vst3" lv2_dest_path="${D}/usr/lib/lv2" headless_dest_path="${D}/usr/bin" data_path="${D}/usr/share/surge" ${S}/build-linux.sh install
}
