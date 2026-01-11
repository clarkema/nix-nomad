{
  pkgs ? import <nixpkgs> { system = builtins.currentSystem; },
}:

pkgs.stdenv.mkDerivation rec {
  name = "pcal";
  version = "4.11.0";
  src = pkgs.fetchurl {
    url = "https://downloads.sourceforge.net/project/pcal/pcal/pcal-${version}/pcal-${version}.tgz";
    sha256 = "8406190e7912082719262b71b63ee31a98face49aa52297db96cc0c970f8d207";
  };

  nativeBuildInputs = with pkgs; [
    groff
  ];

  buildPhase = ''
    ${pkgs.gnumake}/bin/make CC=${pkgs.gcc}/bin/gcc
  '';

  # By default the pcal Makefile will use `compress` on the manpage,
  # which causes it to be double-compressed after mkDerivation has
  # also had its way.  Setting PACK to cat below avoids this.
  installPhase = ''
    ${pkgs.gnumake}/bin/make install PACK=${pkgs.coreutils}/bin/cat DESTDIR=$out BINDIR=/bin MANDIR=/man CATDIR=/man/cat1
  '';
}
