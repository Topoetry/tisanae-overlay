# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module
DESCRIPTION="C-bindings for the Go Cwtch Library"
HOMEPAGE="https://cwtch.im"
if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.openprivacy.ca/cwtch.im/libcwtch-go"
else
	SRC_URI="https://git.openprivacy.ca/cwtch.im/libcwtch-go/archive/${PV}.tar.gz -> ${P}.tar.gz"
	SRC_URI+=" https://raw.githubusercontent.com/Topoetry/libcwtch-go-gentoo-tardeps/${P}-deps.tar.xz"
	# S="${WORKDIR}/libcwtch-go"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	sed -i.bak "s/^package cwtch/\/\/package cwtch/" lib.go
	sed -i.bak "s/^\/\/package main/package main/" lib.go
	sed -i.bak "s/^\/\/func main()/func main()/" lib.go
	eapply_user
}

src_compile() {
	ego build -ldflags "-X main.buildVer=${PV}" -buildmode c-shared -o libCwtch.so
}
src_install() {
	cp -fv libCwtch.so  /usr/lib/
}
