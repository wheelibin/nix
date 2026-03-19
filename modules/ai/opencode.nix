{ pkgs, pkgs-unstable, ... }:

{
  programs.opencode = {
    enable = true;
    package = pkgs-unstable.opencode;
    settings = {
      theme = "kanagawa";
      plugin = [ "superpowers@git+https://github.com/obra/superpowers.git" ];
      provider.amazon-bedrock = {
        options = {
          region = "us-east-1";
          profile = "bedrock";
        };
      };
    };
  };
}
