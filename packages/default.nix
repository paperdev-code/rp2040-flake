{ pkgs ? import <nixpkgs> }:
rec {
  pico-sdk = import ./pico-sdk.nix { inherit pkgs; };
  picotool = import ./picotool.nix { inherit pkgs pico-sdk; };
  default = pico-sdk;
}
