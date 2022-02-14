# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Bule-ish CD ripper"
HOMEPAGE="https://github.com/cyanreg/cyanrip"
SRC_URI="https://github.com/cyanreg/cyanrip/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=media-video/ffmpeg-4.0
		dev-libs/libcdio-paranoia
		>=media-libs/musicbrainz-5
		net-misc/curl
"
RDEPEND="${DEPEND}"
BDEPEND=""
