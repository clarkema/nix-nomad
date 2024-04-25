{ pkgs ? import <nixpkgs> { system = builtins.currentSystem; }
}:

pkgs.stdenv.mkDerivation {
  name = "tm";
  src = pkgs.fetchFromGitHub {
    owner = "clarkema";
    repo = "tm";
    rev = "adfa1665bce4a5a03c3c43ee7bd33f3aa6435522";
    sha256 = "sha256-WVNKX0D+CAkwGepEwIq/ZCLK3I2flIvQimoFvJxgmKY=";
  };
  buildInputs = [ pkgs.makeWrapper ];
  installPhase = ''
    mkdir -p $out/bin $out/share/zsh/functions
    install -Dm0755 bin/tm $out/bin/tm

    # Using 'c' in a single command is a GNU extension, so ensure we're
    # using GNU sed on Darwin
    ${pkgs.gnused}/bin/sed -i -e '1c #! ${pkgs.zsh}/bin/zsh' $out/bin/tm

    # Probably don't really need this here
    # wrapProgram $out/bin/tm --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.coreutils ]}

    cp share/zsh/functions/_tm $out/share/zsh/functions/
  '';
}
