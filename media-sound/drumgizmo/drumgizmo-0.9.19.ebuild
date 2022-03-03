# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="DrumGizmo is a multichannel, multilayered drum plugin."
HOMEPAGE="https://drumgizmo.org"
SRC_URI="http://www.drumgizmo.org/releases/drumgizmo-${PV}/drumgizmo-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=media-libs/libsndfile-1.0.21
		>=media-libs/lv2-1.0
		media-libs/zita-resampler
		media-libs/libsmf"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	 econf --with-lv2dir=/usr/lib64/lv2/ --enable-lv2
}
