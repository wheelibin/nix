{ pkgs, config, ... }:

let
  npmPrefix = "${config.home.homeDirectory}/.npm-global";
  npmCache = "${config.home.homeDirectory}/.npm-cache";
in
{
  home.packages = with pkgs; [
    nodejs_24
    eslint_d
    prettier
  ];

  # Create dirs during activation (no lib.dag dependency)
  home.activation.ensureNpmPrefix = ''
    mkdir -p ${npmPrefix}/bin ${npmPrefix}/lib ${npmPrefix}/node_modules
    mkdir -p ${npmCache}
  '';

  home.file.".npmrc".text = ''
    prefix=${npmPrefix}
    cache=${npmCache}
  '';

  home.sessionPath = [
    "${npmPrefix}/bin"
  ];
}
