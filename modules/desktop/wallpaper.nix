{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.wallpaper;
  setPicture = ''/usr/bin/osascript -e "tell application \"System Events\" to set picture of every desktop to \"$1\""'';
  wallpaperScript = pkgs.writeShellScript "wallpaper" (
    if cfg.file == null then
      ''
        files=(${../../wallpapers}/*)
        set -- "''${files[RANDOM % ''${#files[@]}]}"
        ${setPicture}
      ''
    else
      ''
        set -- "${../../wallpapers}/${cfg.file}"
        ${setPicture}
      ''
  );
in
{
  options.wallpaper.file = lib.mkOption {
    type = lib.types.nullOr (lib.types.enum (builtins.attrNames (builtins.readDir ../../wallpapers)));
    default = null;
    example = "1-cosmic.jpg";
    description = "File in wallpapers/ to pin; null picks a random one at login and 06:00 daily.";
  };

  config = {
    launchd.agents.random-wallpaper = {
      enable = true;
      config = {
        ProgramArguments = [ "${wallpaperScript}" ];
        RunAtLoad = true;
      }
      // lib.optionalAttrs (cfg.file == null) {
        StartCalendarInterval = [
          {
            Hour = 6;
            Minute = 0;
          }
        ];
      };
    };

    home.activation.setWallpaper = config.lib.dag.entryAfter [ "writeBoundary" ] ''
      ${wallpaperScript}
    '';
  };
}
