{ fetchFromGitHub }: {
  btstack = import ./submodules/btstack.nix { inherit fetchFromGitHub; };
  cyw43-driver = import ./submodules/cyw43-driver.nix { inherit fetchFromGitHub; };
  lwip = import ./submodules/lwip.nix { inherit fetchFromGitHub; };
  mbedtls = import ./submodules/mbedtls.nix { inherit fetchFromGitHub; };
  tinyusb = import ./submodules/tinyusb.nix { inherit fetchFromGitHub; };
}
