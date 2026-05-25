{ pkgs, ... }:

let
  qrypad = pkgs.stdenvNoCC.mkDerivation {
    pname = "qrypad";
    version = "1.7.0";

    src = pkgs.fetchurl {
      url = "https://github.com/wheelibin/qrypad/releases/download/v1.7.0/qrypad_1.7.0_darwin_arm64.tar.gz";
      hash = "sha256-pxtZ5Dew0YT2+U5akVfL5c5iQ/AqNuJbuo7KZENYJSg=";
    };

    sourceRoot = ".";

    installPhase = ''
      install -Dm755 qrypad $out/bin/qrypad
    '';

    meta = {
      description = "A terminal SQL client for Postgres, MySQL and SQLite";
      homepage = "https://github.com/wheelibin/qrypad";
      mainProgram = "qrypad";
    };
  };
in
{
  home.packages = [ qrypad ];
}
