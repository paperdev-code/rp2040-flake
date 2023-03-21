{ pkgs ? import <nixpkgs> { }, pico-sdk }: with pkgs;

stdenv.mkDerivation rec {
  pname = "picotool";
  version = "1.1.1";

  src = fetchFromGitHub {
    owner = "raspberrypi";
    repo = "picotool";
    rev = "${version}";
    hash = "sha256-KP5Cq6pYKQI5dV6S4lLapu9EcwAgLgYpK0qreNDZink=";
  };

  buildInputs = [ libusb pico-sdk ];
  nativeBuildInputs = [ cmake pkg-config ];
  cmakeFlags = [ "-DPICO_SDK_PATH=${pico-sdk}/lib/pico-sdk" ];
}
