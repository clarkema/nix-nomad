{
  description = "nomad packages as a flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs }:
    let
      forAllSystems = function:
        nixpkgs.lib.genAttrs [
          "x86_64-linux"
          "x86_64-darwin"
          "aarch64-linux"
          "aarch64-darwin"
        ] (system: function nixpkgs.legacyPackages.${system});
    in {
      packages = forAllSystems(pkgs:
        let
          tm  = import ./tm.nix { inherit pkgs; };
        in
        {
          tm = tm;
        }
      );
    };
}
