{ stdenv
, fetchFromGitHub
  # Submodule options (WIP)
  # What would be the best way to handle these?
  # ex. picotool doesn't need these, & s ome project won't need MbedTLS, etc.
  #, useBtStack ? true
  #, useCyw43Driver ? true
  #, useLwip ? true
  #, useMbedTls ? true
  #, useTinyUsb ? true
}:
let
  submodules = builtins.mapAttrs
    (name: path: (import path) { inherit fetchFromGitHub; })
    (import ./submodules);
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

  dontConfigure = true;
  dontBuild = true;
  dontFixup = true;

  installPhase = ''
    SDK_DIR=$out/lib/pico-sdk
    mkdir -p $SDK_DIR
    mkdir -p $SDK_DIR/lib
    cp -R ${submodules.btstack}/. $SDK_DIR/lib/btstack
    cp -R ${submodules.cyw43-driver}/. $SDK_DIR/lib/cyw43-driver
    cp -R ${submodules.lwip}/. $SDK_DIR/lib/lwip
    cp -R ${submodules.mbedtls}/. $SDK_DIR/lib/mbedtls
    cp -R ${submodules.tinyusb}/. $SDK_DIR/lib/tinyusb
    cp -a ./* $SDK_DIR
  '';
}
