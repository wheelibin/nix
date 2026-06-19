{ pkgs, ... }:

let
  qrypad = pkgs.stdenvNoCC.mkDerivation {
    pname = "qrypad";
    version = "1.8.3";

    src = pkgs.fetchurl {
      url = "https://github.com/wheelibin/qrypad/releases/download/v1.8.3/qrypad_1.8.3_darwin_arm64.tar.gz";
      hash = "sha256-6+IX7bAGfScRXrlGwSCY0870krZ7J6aJQVU+MbWAD2U=";
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
