{ fetchFromGitHub }: {
  btstack = import ./btstack.nix { inherit fetchFromGitHub; };
  cyw43-driver = import ./cyw43-driver.nix { inherit fetchFromGitHub; };
  lwip = import ./lwip.nix { inherit fetchFromGitHub; };
  mbedtls = import ./mbedtls.nix { inherit fetchFromGitHub; };
  tinyusb = import ./tinyusb.nix { inherit fetchFromGitHub; };
}
