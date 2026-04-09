{
  description = "nomad packages as a flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    git-map = {
      url = "github:clarkema/git-map";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      git-map,
    }:
    let
      forAllSystems =
        function:
        nixpkgs.lib.genAttrs [
          "x86_64-linux"
          "x86_64-darwin"
          "aarch64-linux"
          "aarch64-darwin"
        ] (system: function nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (
        pkgs:
        let
          pcal = import ./pcal.nix { inherit pkgs; };
          tm = import ./tm.nix { inherit pkgs; };
        in
        {
          pcal = pcal;
          tm = tm;
          git-map = git-map.packages.${pkgs.system}.git-map;
        }
      );
    };
}
