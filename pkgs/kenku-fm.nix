{ lib, stdenv, fetchurl, autoPatchelfHook, binutils # for `ar`
, alsa-lib, libX11, libXcursor, libXi, libXrandr, libXrender, libXScrnSaver
, libXtst, nss, gtk3, mesa # NEW
}:

stdenv.mkDerivation rec {
  pname = "kenku-fm";
  version = "1.5.4";

  src = fetchurl {
    url =
      "https://github.com/owlbear-rodeo/kenku-fm/releases/download/v${version}/kenku-fm_${version}_amd64.deb";
    sha256 = "888b56c7eaefd2339305c3da6b789e09fdbc388fc7bdc9d18c6ab1130d0ed1c5";
  };

  nativeBuildInputs = [ autoPatchelfHook binutils ];

  buildInputs = [
    alsa-lib
    libX11
    libXcursor
    libXi
    libXrandr
    libXrender
    libXScrnSaver
    libXtst
    nss
    gtk3
    mesa # NEW: provides libgbm.so.1
  ];

  dontBuild = true;

  unpackPhase = ''
    ar x "$src"
    tar --no-same-owner --no-same-permissions -xf data.tar.*
  '';

  installPhase = ''
    mkdir -p "$out"

    # .deb payload goes into usr/lib/kenku-fm
    cp -r usr/lib/kenku-fm/* "$out/"

    mkdir -p "$out/bin"
    ln -s "$out/kenku-fm" "$out/bin/kenku-fm"
  '';

  meta = with lib; {
    description = "Online tabletop audio sharing for Discord";
    homepage = "https://www.kenku.fm/";
    license = licenses.gpl3Only;
    platforms = [ "x86_64-linux" ];
    mainProgram = "kenku-fm";
  };
}
