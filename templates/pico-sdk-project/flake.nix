{
  description = "Raspberry Pi Pico SDK project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    rp2040.url = "github:paperdev-code/rp2040-flake";
  };

  outputs = { nixpkgs, flake-utils, ... }@inputs:
    let
      overlays = [
        inputs.rp2040.overlays.default
      ];
    in
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = (import nixpkgs) { inherit overlays system; };
      in
      rec {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            pico-sdk
            picotool
            cmake
            newlib-nano
            gcc-arm-embedded
          ] ++ inputs.rp2040.suggested pkgs;

          shellHook = ''
            export PICO_SDK_PATH=${pkgs.pico-sdk}/lib/pico-sdk
            export C_INCLUDE_PATH=${pkgs.gcc-arm-embedded}/arm-none-eabi/include:$C_INCLUDE_PATH
          '';
        };
      });
}
