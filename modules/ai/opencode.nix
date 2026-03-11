{ pkgs, pkgs-unstable, ... }:

let
  superpowers = pkgs.fetchFromGitHub {
    owner = "obra";
    repo = "superpowers";
    rev = "363923f74aa9cd7b470c0aaa73dee629a8bfdc90";
    hash = "sha256-AyRGXwWI9xHGeHw9vD64cnV19txR/lOtxudcHnbV75I=";
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
