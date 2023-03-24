{ stdenv, fetchFromGitHub, callPackage, cmake }:

stdenv.mkDerivation rec {
  pname = "pico-sdk";
  version = "1.5.0";

  src = fetchFromGitHub {
    owner = "raspberrypi";
    repo = "pico-sdk";
    rev = "${version}";
    hash = "sha256-p69go8KXQR21szPb+R1xuonyFj+ZJDunNeoU7M3zIsE=";
  };

  btstack = import ./submodules/btstack.nix { inherit fetchFromGitHub; };

  cyw43-driver = import ./submodules/cyw43-driver.nix { inherit fetchFromGitHub; };

  lwip = import ./submodules/lwip.nix { inherit fetchFromGitHub; };

  mbedtls = import ./submodules/mbedtls.nix { inherit fetchFromGitHub; };

  tinyusb = import ./submodules/tinyusb.nix { inherit fetchFromGitHub; };

  # submodules = import ./submodules { inherit fetchFromGitHub callPackage; };

  nativeBuildInputs = [ cmake ];

  sourceRoot = "source/tools/pioasm";

  installPhase = ''
    SDK_DIR=$out/lib/pico-sdk
    mkdir -p $SDK_DIR
    mkdir -p $SDK_DIR/lib
    cp -R ${btstack}/. $SDK_DIR/lib/btstack
    cp -R ${cyw43-driver}/. $SDK_DIR/lib/cyw43-driver
    cp -R ${lwip}/. $SDK_DIR/lib/lwip
    cp -R ${mbedtls}/. $SDK_DIR/lib/mbedtls
    cp -R ${tinyusb}/. $SDK_DIR/lib/tinyusb
    cp -a ../../../* $SDK_DIR
    chmod +x $SDK_DIR/tools/pioasm/build/pioasm
  '';
}
