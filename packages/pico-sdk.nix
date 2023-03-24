{ stdenv, fetchFromGitHub, callPackage, cmake }:
let
  submodules = import ./submodules;
  btstack = import submodules.btstack { inherit fetchFromGitHub; };
  cyw43-driver = import submodules.cyw43-driver { inherit fetchFromGitHub; };
  lwip = import submodules.lwip { inherit fetchFromGitHub; };
  mbedtls = import submodules.mbedtls { inherit fetchFromGitHub; };
  tinyusb = import submodules.tinyusb { inherit fetchFromGitHub; };
in
stdenv.mkDerivation rec {
  pname = "pico-sdk";
  version = "1.5.0";

  src = fetchFromGitHub {
    owner = "raspberrypi";
    repo = "pico-sdk";
    rev = "${version}";
    hash = "sha256-p69go8KXQR21szPb+R1xuonyFj+ZJDunNeoU7M3zIsE=";
  };

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
