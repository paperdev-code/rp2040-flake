{ fetchFromGitHub }: {
  btstack = import ./btstack.nix { fetchFromGitHub = fetchFromGitHub; };
  cyw43-driver = import ./cyw43-driver.nix { fetchFromGitHub = fetchFromGitHub; };
  lwip = import ./lwip.nix { fetchFromGitHub = fetchFromGitHub; };
  mbedtls = import ./mbedtls.nix { fetchFromGitHub = fetchFromGitHub; };
  tinyusb = import ./tinyusb.nix { fetchFromGitHub = fetchFromGitHub; };
}
