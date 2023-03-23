{ pkgs ? import <nixpkgs> }:
let
  package = pkgs.callPackage;
in
rec {
  pico-sdk = package ./pico-sdk.nix { };
  picotool = package ./picotool.nix { inherit pico-sdk; };
  default = pico-sdk;
}
