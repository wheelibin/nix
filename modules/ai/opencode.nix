{ pkgs, pkgs-unstable, ... }:

let
  superpowers = pkgs.fetchFromGitHub {
    owner = "obra";
    repo = "superpowers";
    rev = "v5.0.5";
    # hash = pkgs.lib.fakeHash;
    hash = "sha256-Yq7y6VDrREV60WpfaGsYdnWqoaS7g1hrtci4bGtgtZM=";
  };
in
{
  programs.opencode = {
    enable = true;
    package = pkgs-unstable.opencode;
    settings = {
      theme = "kanagawa";

      provider.amazon-bedrock = {
        options = {
          region = "us-east-1";
          profile = "bedrock";
        };
      };
    };
  };

  xdg.configFile."opencode/plugins/superpowers.js".source =
    "${superpowers}/.opencode/plugins/superpowers.js";

  xdg.configFile."opencode/skills/superpowers".source = "${superpowers}/skills";
}
