{ lib, stdenv, fetchurl, autoPatchelfHook, dpkg, alsa-lib, libX11, libXcursor
, libXi, libXrandr, libXrender, libXScrnSaver, libXtst, nss, gtk3 }:

stdenv.mkDerivation rec {
  pname = "kenku-fm";
  version = "1.5.4";

  src = fetchurl {
    url =
      "https://github.com/owlbear-rodeo/kenku-fm/releases/download/v${version}/kenku-fm_${version}_amd64.deb";
    # From the official GitHub release page
    sha256 = "888b56c7eaefd2339305c3da6b789e09fdbc388fc7bdc9d18c6ab1130d0ed1c5";
  };

  nativeBuildInputs = [ autoPatchelfHook dpkg ];

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
  ];

  dontBuild = true;

  unpackPhase = ''
    dpkg-deb -x $src .
  '';

  installPhase = ''
    mkdir -p $out
    # Copy files from the .deb payload
    cp -r "opt/Kenku FM"/* $out/

    # Provide a nice binary on PATH
    mkdir -p $out/bin
    ln -s $out/kenku-fm $out/bin/kenku-fm
  '';

  meta = with lib; {
    description = "Online tabletop audio sharing for Discord";
    homepage = "https://www.kenku.fm/";
    license = licenses.gpl3Only;
    platforms = [ "x86_64-linux" ];
    mainProgram = "kenku-fm";
  };
}
