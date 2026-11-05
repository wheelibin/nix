# Melange theme. Selected in modules/theme.nix; see that file for field docs.
# Plain attrset (no pkgs) so any module can `import` it.
let
  # Melange dark, from melange-nvim lua/melange/palettes/dark.lua
  palette = {
    bg = "#292522";
    float = "#34302C";
    sel = "#403A36";
    ui = "#867462";
    com = "#C1A78E";
    fg = "#ECE1D7";
    red = "#D47766";
    yellow = "#EBC06D";
    orange = "#E49B5D";
    green = "#85B695";
    cyan = "#89B3B6";
    blue = "#A3A9CE";
    magenta = "#CF9BC2";
    # dim variants, used by the terminal's normal ANSI colors (Ghostty's "Melange Dark")
    dimRed = "#BD8183";
    dimGreen = "#78997A";
    dimBlue = "#7F91B2";
    dimMagenta = "#B380B0";
    dimCyan = "#7B9695";
  };
in
{
  name = "melange";

  nvim = {
    repo = "savq/melange-nvim";
    colorscheme = "melange";
    globals = { }; # vim.g.* set before the colorscheme, e.g. { gruvbox_material_background = "hard"; }
    setup = null; # or { module = "kanagawa"; opts = { transparent = true; }; }
  };

  ghostty = "Melange Dark";

  tmux = {
    plugin = null; # e.g. "kanagawa"; null = style from roles
    extraConfig = ""; # plugin options, only used when plugin is set
  };

  inherit palette;

  # Terminal colors, as in Ghostty's "Melange Dark"; ansi is colors 0-15.
  terminal = with palette; {
    background = bg;
    foreground = fg;
    cursor = fg;
    cursorText = bg;
    selectionBackground = fg;
    selectionForeground = sel;
    ansi = [
      float
      dimRed
      dimGreen
      orange
      dimBlue
      dimMagenta
      dimCyan
      com
      ui
      red
      green
      yellow
      blue
      magenta
      cyan
      fg
    ];
  };

  roles = {
    bg = palette.bg; # base background
    surface = palette.float; # popups, inactive bars
    selection = palette.sel; # selected row / range
    muted = palette.ui; # borders, separators, hints
    subtle = palette.com; # secondary text
    text = palette.fg;
    accent = palette.blue; # primary highlight, active items
    border = palette.cyan; # focused borders
    special = palette.magenta; # selection mode, media, pointers
    highlight = palette.orange; # search / find matches
    error = palette.red;
    warning = palette.yellow;
    success = palette.green;
    info = palette.cyan;
  };
}
