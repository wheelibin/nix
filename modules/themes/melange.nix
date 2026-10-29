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
