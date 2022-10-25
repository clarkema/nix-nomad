with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "tm";
  src = fetchFromGitHub {
    owner = "clarkema";
    repo = "tm";
    rev = "adfa1665bce4a5a03c3c43ee7bd33f3aa6435522";
    sha256 = "sha256-WVNKX0D+CAkwGepEwIq/ZCLK3I2flIvQimoFvJxgmKY=";
  };
  buildInputs = [ makeWrapper ];
  installPhase = ''
    mkdir -p $out/bin $out/share/zsh/functions
    install -Dm0755 bin/tm $out/bin/tm

    # Using 'c' in a single command is a GNU extension, so ensure we're
    # using GNU sed on Darwin
    ${gnused}/bin/sed -i -e '1c #! ${zsh}/bin/zsh' $out/bin/tm

    # Probably don't really need this here
    # wrapProgram $out/bin/tm --prefix PATH : ${lib.makeBinPath [ coreutils ]}

    cp share/zsh/functions/_tm $out/share/zsh/functions/
  '';
}
