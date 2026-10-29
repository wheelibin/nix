# Single source of truth for the shared theme. Switching theme = change the import
# below to another file in ./themes (e.g. ./themes/melange.nix, ./themes/rose-pine.nix).
# Each theme file defines:
#   nvim    -> plugin repo, colorscheme, optional vim.g globals / setup() call
#             (generated into nvim/lua/theme_generated.lua)
#   ghostty -> built-in theme name (generated into ghostty/theme.conf)
#   tmux    -> nixpkgs tmuxPlugins name, or null to style from `roles`
#   roles   -> what tools without a theme plugin use (tmux, lazygit, yazi,
#              btop, fzf). Modules reference roles only, never raw hues.
import ./themes/melange.nix
