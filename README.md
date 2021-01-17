# Nomad on Nix

This repository contains [Nix](https://nixos.org/) expressions for some of my
command-line utilities.

I’m only just experimenting with Nix at the moment, so expect this to be very
unidiomatic and subject to random change for a while.

# Example installation and use

```sh
$ nix-channel --add https://github.com/clarkema/nix-nomad/archive/master.tar.gz nomad
$ nix-channel --update
$ nix-env -iA tm
```
