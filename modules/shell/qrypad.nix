{ pkgs, ... }:

let
  qrypad = pkgs.stdenvNoCC.mkDerivation {
    pname = "qrypad";
    version = "1.8.2";

    src = pkgs.fetchurl {
      url = "https://github.com/wheelibin/qrypad/releases/download/v1.8.2/qrypad_1.8.2_darwin_arm64.tar.gz";
      hash = "sha256-rHvo1hiilSXedO0udt0Ua2tYbEtovJjtq3EvT+NlzFQ=";
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
