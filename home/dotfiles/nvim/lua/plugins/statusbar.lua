-- local colors = {
--   -- Main colors
--   normal_fg = "#CCD5E5",
--   normal_bg = "#191d23",
--   panel_bg = "#1B1F25",
--   float_bg = "#1C2127",
--   normal_bg_alt = "#20252E",
--   normal_bg_accent = "#242932",
--   comment_fg = "#474B65",
--   nontext_fg = "#363848",
--
--   -- Accent colors
--   important = "#6A8BE3",
--   keyword = "#A9B9EF",
--   constant = "#BCB6EC",
--   string = "#74BAA8",
--   cursor = "#5DCD9A",
--   search = "#E9B872",
--   number = "#B85B53",
--
--   -- Status colors
--   info = "#1A8C9B",
--   warn = "#FFA630",
--   error = "#F71735",
--
--   -- Git colors
--   git_add_col = "#366A4C",
--   git_change_col = "#3F58BB",
--   git_delete_col = "#942B27",
-- }

-- local custom_theme = {
--   normal = {
--     a = { fg = colors.normal_fg, bg = colors.normal_bg_alt },
--     b = { fg = colors.normal_fg, bg = colors.normal_bg_alt },
--     c = { fg = colors.normal_fg, bg = colors.normal_bg },
--     x = { fg = colors.normal_fg, bg = colors.normal_bg_alt },
--     y = { fg = colors.normal_fg, bg = colors.normal_bg_alt },
--     z = { fg = colors.normal_fg, bg = colors.normal_bg_alt },
--   },
--
--   insert = {
--     a = { fg = colors.normal_bg, bg = colors.string },
--   },
--
--   visual = {
--     a = { fg = colors.normal_bg, bg = colors.constant },
--   },
--
--   replace = {
--     a = { fg = colors.normal_bg, bg = colors.number },
--   },
--
--   command = {
--     a = { fg = colors.normal_bg, bg = colors.search },
--   },
--
--   inactive = {
--     a = { fg = colors.comment_fg, bg = colors.panel_bg },
--     b = { fg = colors.comment_fg, bg = colors.panel_bg },
--     c = { fg = colors.comment_fg, bg = colors.normal_bg },
--   },
-- }

return {
  {
    'nvim-lualine/lualine.nvim',
    lazy = true,
    event = "BufEnter",
    dependencies = { 'f-person/git-blame.nvim' },
    config = function()
      -- set up git blame to work with lualine
      local git_blame = require('gitblame')
      vim.g.gitblame_enable = 1
      vim.g.gitblame_display_virtual_text = 0
      vim.g.gitblame_date_format = '%r'

      local config = {
        options = {
          theme = "kanagawa",
          disabled_filetypes = { 'neo-tree' },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = {
            { 'branch', icon = '' },
            {
              'diff',
              diff_color = {
                -- Same color values as the general color option can be used here.
                added = 'GitSignsAdd',       -- Changes the diff's added color
                modified = 'GitSignsChange', -- Changes the diff's modified color
                removed = 'GitSignsDelete'   -- Changes the diff's removed color you
              }
            },
          },
          lualine_c = {
            {
              git_blame.get_current_blame_text,
              cond = git_blame.is_blame_text_available,
              color = { bg = 'none' }, -- Force transparent background
            },
          },
          lualine_x = {
            { 'filename', color = { bg = 'none' } },
            { 'filetype', color = { bg = 'none' } }
          }

        }
      }

      require('lualine').setup(config)
    end
  }
}
