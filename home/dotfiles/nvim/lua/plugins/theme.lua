return {
  -- {
  --   "savq/melange-nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     -- vim.cmd.colorscheme("melange")
  --   end
  -- },
  -- {
  --   "mcauley-penney/techbase.nvim",
  --   opts = {
  --     italic_comments = true,
  --
  --     -- set to true to make the background, floating windows, statusline,
  --     -- signcolumn, foldcolumn, and tabline transparent
  --     -- transparent = true,
  --
  --     plugin_support = {
  --       aerial = true,
  --       blink = true,
  --       edgy = false,
  --       gitsigns = true,
  --       hl_match_area = false,
  --       lazy = true,
  --       lualine = true,
  --       mason = true,
  --       mini_cursorword = false,
  --       nvim_cmp = true,
  --       vim_illuminate = false,
  --       visual_whitespace = false,
  --     },
  --
  --     -- allows you to override any highlight group for finer-grained control
  --     hl_overrides = {},
  --   },
  --   init = function()
  --     -- vim.cmd.colorscheme("techbase")
  --     -- vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#474b65", fg = "#ccd5e5", bold = true })
  --   end,
  --   priority = 1000,
  -- },
  -- {
  --   "vague2k/vague.nvim",
  --   lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other plugins
  --   config = function()
  --     -- NOTE: you do not need to call setup if you don't want to.
  --     require("vague").setup({
  --       transparent = true
  --     })
  --     -- vim.cmd("colorscheme vague")
  --   end
  -- },
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require("kanagawa").setup({
        theme = "dragon",
        transparent = true,
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none",
              },
            },
          },
        },
      })
      vim.cmd.colorscheme('kanagawa')
    end,
  },
  -- {
  --   "EdenEast/nightfox.nvim",
  --   name = "theme: nightfox",
  --   priority = 1000,
  --   config = function()
  --     require("nightfox").setup({
  --       options = {
  --         transparent = true,
  --       },
  --     })
  --     -- vim.cmd('colorscheme carbonfox')
  --   end,
  -- },
  -- {
  --   "rose-pine/neovim",
  --   name = "theme: rose-pine",
  --   config = function()
  --     require("rose-pine").setup({
  --       -- variant = "moon",
  --       styles = {
  --         bold = true,
  --         italic = true,
  --         transparency = true,
  --       },
  --     })
  --     -- vim.cmd('colorscheme rose-pine')
  --   end,
  -- },
  -- {
  --   "sainnhe/gruvbox-material",
  --   name = "theme: gruvbox-material",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     -- Optionally configure and load the colorscheme
  --     -- directly inside the plugin declaration.
  --     -- vim.g.gruvbox_material_enable_italic = true
  --     -- vim.g.gruvbox_material_foreground = 'mix'
  --     -- vim.g.gruvbox_material_enable_bold = true
  --
  --     -- vim.g.gruvbox_material_background = 'hard'
  --     -- vim.g.gruvbox_material_better_performance = 1
  --     -- vim.cmd.colorscheme('gruvbox-material')
  --   end,
  -- },
  -- {
  --   "catppuccin/nvim",
  --   name = "theme: catppuccin",
  --   priority = 1000,
  --   config = function()
  --     -- vim.cmd('colorscheme catppuccin')
  --   end,
  -- },
  -- {
  --   'sainnhe/everforest',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     -- Optionally configure and load the colorscheme
  --     -- directly inside the plugin declaration.
  --     -- vim.g.everforest_enable_italic = true
  --     -- vim.g.everforest_background = 'hard'
  --     -- vim.g.everforest_better_performance = 1
  --     -- vim.cmd.colorscheme('everforest')
  --   end
  -- }
}
