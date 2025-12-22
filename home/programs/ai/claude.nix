{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    claude-code
  ];

  programs.zsh = {
    enable = true;
    initContent = ''
      [ -f "$HOME/.zshrc.claude" ] && source "$HOME/.zshrc.claude"
    '';
  };
}
