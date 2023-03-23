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

  btstack = fetchFromGitHub {
    owner = "bluekitchen";
    repo = "btstack";
    rev = "0d212321a995ed2f9a80988f73ede854c7ad23b8";
    hash = "sha256-EkeHDBwL5+BzBQl2j9IMJdDMSgdIkQTBOpJrE5W/Fuo=";
  };

  cyw43-driver = fetchFromGitHub {
    owner = "georgerobotics";
    repo = "cyw43-driver";
    rev = "9bfca61173a94432839cd39210f1d1afdf602c42";
    hash = "sha256-iWZDrAAt469yEmH7QXYn35xS9dm7vzL1vSWn6oXneUQ=";
  };

  lwip = fetchFromGitHub {
    owner = "lwip-tcpip";
    repo = "lwip";
    rev = "239918ccc173cb2c2a62f41a40fd893f57faf1d6";
    hash = "sha256-oV5YKDDj3dzo/ZR2AQzZKT6jv3n6OpwYu1BqXoK6cVA=";
  };

  mbedtls = fetchFromGitHub {
    owner = "MBed-TLS";
    repo = "mbedtls";
    rev = "a77287f8fa6b76f74984121fdafc8563147435c8";
    hash = "sha256-g3V0NL4FTjA4NV4ajAqQZGVmKGno1NEFzsojCgRxrQw=";
  };

  tinyusb = fetchFromGitHub {
    owner = "hathach";
    repo = "tinyusb";
    rev = "86c416d4c0fb38432460b3e11b08b9de76941bf5";
    hash = "sha256-SpPDJitK1qwQnjdDLmmoRfNlzby0RX4+MgmoDBxVJKA=";
  };

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
