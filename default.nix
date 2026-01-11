let
  pkgs = {
    pcal = import ./pcal.nix;
    tm = import ./tm.nix;
  };
in pkgs
