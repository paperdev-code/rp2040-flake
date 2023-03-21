{
  description = "Raspberry Pi Pico SDK and related tools";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in
        rec {
          packages = import ./packages { inherit pkgs; };
          overlays.default = final: prev: {
            pico-sdk = packages.pico-sdk;
            picotool = packages.picotool;
          };
        });
}
