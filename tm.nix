with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "tm";
  src = fetchFromGitHub {
    owner = "clarkema";
    repo = "tm";
    rev = "master";
    sha256 = "0zya4zc2ra5v5rj8rn5n421dbg9lcbxfc0jcqdbmcg4csgx5ah0j";
  };
  installPhase = ''
    mkdir -p $out/bin $out/share/zsh/functions
    cp bin/tm $out/bin/
    chmod +x $out/bin/tm
    cp share/zsh/functions/_tm $out/share/zsh/functions/
  '';
}
