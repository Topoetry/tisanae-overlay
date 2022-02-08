# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs eutils

[ "$PV" == "9999" ] && inherit git-r3

DESCRIPTION="Feature-rich wifi hotspot creator for Linux which provides both GUI and command-line interface. It is also able to create a hotspot using the same wifi card which is connected to an AP already ( Similar to Windows 10)."
HOMEPAGE="https://github.com/lakinduakash/linux-wifi-hotspot"
SLOT=0

if [ "$PV" == "9999" ]; then
	EGIT_REPO_URI="https://github.com/lakinduakash/linux-wifi-hotspot.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/lakinduakash/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="BSD"

src_install() {
	emake DESTDIR="${D}" install
}
