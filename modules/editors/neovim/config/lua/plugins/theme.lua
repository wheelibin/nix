-- Colorscheme is defined once in modules/theme.nix and generated into
-- lua/theme_generated.lua by Home Manager.
local t = require("theme_generated")

return {
  {
    t.repo,
    lazy = false,
    priority = 1000,
    config = function()
      for k, v in pairs(t.globals or {}) do
        vim.g[k] = v
      end
      if t.setup then require(t.setup.module).setup(t.setup.opts) end
      vim.cmd.colorscheme(t.colorscheme)
    end,
  },
}
