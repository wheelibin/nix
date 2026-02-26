{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    claude-code
  ];

  programs.zsh = {
    enable = true;
    initContent = ''
      [ -f "$HOME/.env.claude" ] && source "$HOME/.env.claude"
    '';
  };
}
