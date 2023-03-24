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
        # pkgs = (import nixpkgs) { inherit system; };
        rp2040-shell = inputs.rp2040.devShells.${system}.default;
      in
      rec {
        devShells.default = rp2040-shell;
      }
    );
}
