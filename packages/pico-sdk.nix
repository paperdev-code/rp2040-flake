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

  submodules = import ./submodules { fetchFromGitHub = fetchFromGitHub; };

  nativeBuildInputs = [ cmake ];

  sourceRoot = "source/tools/pioasm";

  installPhase = ''
    SDK_DIR=$out/lib/pico-sdk
    mkdir -p $SDK_DIR
    mkdir -p $SDK_DIR/lib
    cp -R ${submodules.btstack}/. $SDK_DIR/lib/btstack
    cp -R ${submodules.cyw43-driver}/. $SDK_DIR/lib/cyw43-driver
    cp -R ${submodules.lwip}/. $SDK_DIR/lib/lwip
    cp -R ${submodules.mbedtls}/. $SDK_DIR/lib/mbedtls
    cp -R ${submodules.tinyusb}/. $SDK_DIR/lib/tinyusb
    cp -a ../../../* $SDK_DIR
    chmod +x $SDK_DIR/tools/pioasm/build/pioasm
  '';
}
