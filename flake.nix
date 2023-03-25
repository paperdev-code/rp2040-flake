{
  description = "Raspberry Pi Pico SDK and related tools";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = (import nixpkgs) { inherit system; };
        in
        rec {
          # Packages defined by this flake
          packages = import ./packages { inherit pkgs; };

          # Nixpkgs overlay
          overlays.default = final: prev: {
            pico-sdk = packages.pico-sdk;
            picotool = packages.picotool;
          };

          # List of packages to quickly populate your devShell with.
          toolchain = with pkgs; [
            cmake
            usbutils
            python3
            newlib-nano
            gcc-arm-embedded
          ] ++ builtins.attrValues packages;

          # Simple shell with basic toolchain
          devShells.default = pkgs.mkShell {
            packages = toolchain;
            shellHook = ''
              export PICO_SDK_PATH=${packages.pico-sdk}/lib/pico-sdk
            '';
          };
        }) // {

      # Templates
      templates = rec {
        pico-sdk-project = {
          path = ./templates/pico-sdk-project;
          description = "A Pico SDK project";
        };
        default = pico-sdk-project;
      };
    };
}
