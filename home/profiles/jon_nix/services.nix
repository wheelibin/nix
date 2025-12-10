{ ... }:
{

  services.dropbox = {
    enable = true;
    # Optional but often useful:
    # path = [ pkgs.xdg-utils pkgs.gnome.zenity ];
  };
}
