# Rose Pine theme. Selected in modules/theme.nix; see that file for field docs.
# Plain attrset (no pkgs) so any module can `import` it.
let
  # Rose Pine main, from rose-pine/neovim lua/rose-pine/palette.lua
  palette = {
    base = "#191724";
    surface = "#1f1d2e";
    overlay = "#26233a";
    muted = "#6e6a86";
    subtle = "#908caa";
    text = "#e0def4";
    love = "#eb6f92";
    gold = "#f6c177";
    rose = "#ebbcba";
    pine = "#31748f";
    foam = "#9ccfd8";
    iris = "#c4a7e7";
  };
in
{
  name = "rose-pine";

  nvim = {
    repo = "rose-pine/neovim";
    colorscheme = "rose-pine";
    globals = { };
    setup = null;
  };

  ghostty = "Rose Pine";

  tmux = {
    plugin = null;
    extraConfig = "";
  };

  inherit palette;

  roles = {
    bg = palette.base;
    surface = palette.surface;
    selection = palette.overlay;
    muted = palette.muted;
    subtle = palette.subtle;
    text = palette.text;
    accent = palette.iris;
    border = palette.foam;
    special = palette.rose;
    highlight = palette.gold;
    error = palette.love;
    warning = palette.gold;
    success = palette.pine;
    info = palette.foam;
  };
}
