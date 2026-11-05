{ lib, ... }:

let
  theme = import ../../theme.nix;
  t = theme.terminal;
  rex = "$HOME/Library/Application Support/com.superlogical.rex/RexServer/Versions/Current/Rex Server.app/Contents/MacOS/rex";
in
{
  home.file.".config/rex" = {
    source = ./config;
    recursive = true;
  };

  # Rex.app settings. Key names are Rex's own (read back from `defaults read com.superlogical.rex`),
  # undocumented, so a Rex update may rename them; Rex may need a restart to pick up changes.
  # Not pinned: darkThemeID (set by the theme import below), sidebarCollapsed (cmd+/ state).
  targets.darwin.defaults."com.superlogical.rex" = {
    "Workspace.terminalFontName" = "JetBrainsMonoNL Nerd Font Mono";
    "Workspace.terminalFontStyle" = "ExtraLight";
    "Workspace.terminalFontPointSize" = 20.0;
    "Workspace.terminalCellHeightPercent" = -8.0; # Ghostty's adjust-cell-height
    "Workspace.terminalFontSmoothing" = false;
    "Workspace.terminalOptionKeyBehavior" = "actsAsAlt";
    "Workspace.terminalUseThemePalette" = false;
    "Workspace.lightThemeID" = "merino-light";
    "Workspace.interfaceStyle" = "blendTheme";
    "Workspace.usesPaneGlass" = true;
    "Workspace.animationStyle" = "snappy";
    "Workspace.inactivePaneFadeMode" = "both";
    "Workspace.usesStandardInactiveWindowPaneStyles" = true;
    "Workspace.showsPaneHeaders" = false;
    "Workspace.balancesSplitsOnCreation" = false;
    "Workspace.tabStyle" = "vertical";
    "Workspace.tabIconTintMode" = "off";
    "Workspace.sidebarPosition" = "left";
    "rex.agents.names-sessions" = false;
    # lets the sessionizer switch sessions and `home-manager switch` import the theme
    "rex.client.remoteControl" = true;
  };

  # Ghostty-format theme file, imported by Rex's "Apply Nix Theme" action (init.lua).
  xdg.configFile."rex/theme" = {
    text = ''
      ${
        lib.concatImapStrings (i: c: "palette = ${toString (i - 1)}=${c}\n") t.ansi
      }background = ${t.background}
      foreground = ${t.foreground}
      cursor-color = ${t.cursor}
      cursor-text = ${t.cursorText}
      selection-background = ${t.selectionBackground}
      selection-foreground = ${t.selectionForeground}
    '';
    # Needs the app running with Remote Control on; otherwise run "Apply Nix Theme" in Rex.
    onChange = ''
      "${rex}" --autostart=false do client.theme.import path="$HOME/.config/rex/theme" >/dev/null 2>&1 \
        || echo "Rex: run 'Apply Nix Theme' to load the new theme"
    '';
  };
}
