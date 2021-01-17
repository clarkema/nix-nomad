with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "tm";
  src = fetchFromGitHub {
    owner = "clarkema";
    repo = "tm";
    rev = "master";
    sha256 = "0zya4zc2ra5v5rj8rn5n421dbg9lcbxfc0jcqdbmcg4csgx5ah0j";
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
