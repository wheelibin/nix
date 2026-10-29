{ config, pkgs, ... }:

let
  randomWallpaper = pkgs.writeShellScript "random-wallpaper" ''
    files=(${../../wallpapers}/*)
    /usr/bin/osascript -e "tell application \"System Events\" to set picture of every desktop to \"''${files[RANDOM % ''${#files[@]}]}\""
  '';
in
{
  launchd.agents.random-wallpaper = {
    enable = true;
    config = {
      ProgramArguments = [ "${randomWallpaper}" ];
      RunAtLoad = true;
      StartCalendarInterval = [
        {
          Hour = 9;
          Minute = 0;
        }
      ];
    };
  };

  home.activation.setWallpaper = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    ${randomWallpaper}
  '';
}
