{
  description = "Raspberry Pi Pico SDK and related tools";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    let
      outputs = flake-utils.lib.eachDefaultSystem
        (system:
          let
            pkgs = (import nixpkgs) { inherit system; };
          in
          {
            packages = import ./packages { inherit pkgs; };
          });
    in
    outputs
    // {
      overlays.default = final: prev: {
        pico-sdk = outputs.packages.${prev.system}.pico-sdk;
        picotool = outputs.packages.${prev.system}.picotool;
      };

      templates = rec {
        pico-sdk-project = {
          path = ./templates/pico-sdk-project;
          description = "A Pico SDK project.";
        };
        default = pico-sdk-project;
      };

      udev-rules = ''
        # RPi Pico in BOOTSEL mode
        SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="0003", MODE="0666"
        # RPi Pico
        SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="000a", MODE="0666"
      '';
    };
}
