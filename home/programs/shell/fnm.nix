{ pkgs, ... }:

{

  home.packages = [ pkgs.fnm ];

  programs.zsh = {
    enable = true;
    initContent = ''
      eval "$(fnm env --use-on-cd --shell zsh)"
    '';
  };
}
