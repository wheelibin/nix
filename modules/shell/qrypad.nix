{ pkgs, ... }:

let
  qrypad = pkgs.stdenvNoCC.mkDerivation {
    pname = "qrypad";
    version = "1.3.0";

    src = pkgs.fetchurl {
      url = "https://github.com/wheelibin/qrypad/releases/download/v1.3.0/qrypad_1.3.0_darwin_arm64.tar.gz";
      hash = "sha256-YAZ1fBYjsfmVM8K62fs8pIfNy43hzOGvHfeQViUOm/I=";
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
