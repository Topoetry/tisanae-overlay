# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

if [[ ${PV} == *9999 ]]; then
	SCM="git-r3"
	EGIT_REPO_URI="https://github.com/karlstav/cava.git"
fi

inherit autotools ${SCM}

DESCRIPTION="Console-based audio visualizer for ALSA"
HOMEPAGE="https://github.com/karlstav/cava"

if [[ ${PV} == *9999 ]]; then
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="https://github.com/karlstav/cava/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="alsa debug portaudio pulseaudio sndio system-iniparser"

DEPEND="
	alsa? ( media-libs/alsa-lib )
	portaudio? ( media-libs/portaudio )
	pulseaudio? ( media-sound/pulseaudio )
	sndio? ( media-sound/sndio )
	system-iniparser? ( dev-libs/iniparser:4 )
	sys-libs/ncurses
	sci-libs/fftw:3.0
"
RDEPEND="${DEPEND}"
BDEPEND=""

DOCS=(README.md example_files/)

src_prepare() {
	default

	eautoreconf
}

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_enable alsa input-alsa) \
		$(use_enable portaudio input-portaudio) \
		$(use_enable pulseaudio input-pulse) \
		$(use_enable sndio input-sndio) \
		$(use_enable system-iniparser) \
		--prefix="${EPREFIX}/usr" \
		--docdir="${EPREFIX}/usr/share/doc/${PF}"
}

src_compile() {
	emake
}

src_install() {
	emake install \
		DESTDIR="${D}"

	einstalldocs
}
