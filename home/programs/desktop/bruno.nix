{ pkgs, ... }:

{

  # Install Bruno GUI + CLI
  home.packages = with pkgs; [ bruno bruno-cli ];

  # Make GUI appear in ~/Applications
  home.file."Applications/Bruno.app".source =
    "${pkgs.bruno}/Applications/Bruno.app";

}
