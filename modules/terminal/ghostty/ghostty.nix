{ ... }:

let
  theme = import ../../theme.nix;
in
{
  home.file.".config/ghostty" = {
    source = ./config;
    recursive = true;
  };

  # included from ./config via `config-file`
  xdg.configFile."ghostty/theme.conf".text = "theme = ${theme.ghostty}\n";
}
