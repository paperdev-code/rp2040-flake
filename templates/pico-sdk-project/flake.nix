{
  description = "Raspberry Pi Pico SDK project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    rp2040.url = "github:paperdev-code/rp2040-flake";
  };

  outputs = { nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = (import nixpkgs) { inherit system; };
      in
      rec {
        devShells = inputs.rp2040.devShells;
      }
    );
}
