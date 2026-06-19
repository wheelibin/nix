-- nvim-treesitter itself (parsers + queries) is provided by nix via
-- `programs.neovim.plugins` in neovim.nix, NOT by lazy.nvim. Highlight,
-- indent, and folding are handled natively by Neovim (see autocommands.lua
-- and options.lua). The specs below are the treesitter-adjacent plugins
-- that are still managed at runtime by lazy.nvim.
return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost",
    config = function()
      require("treesitter-context").setup({
        separator = "┈",
      })
      vim.keymap.set("n", "<leader>c", require("treesitter-context").go_to_context)
    end,
  },
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    init = function() vim.g.matchup_text_obj_enabled = 0 end,
  },
  {
    -- navigation using treesitter
    "aaronik/treewalker.nvim",
    lazy = true,
    event = "BufEnter",
    opts = {
      highlight = true, -- default is false
    },
    keys = {
      { "<C-n>", ":Treewalker Down<CR>", mode = { "n" } },
      { "<C-e>", ":Treewalker Up<CR>", mode = { "n" } },
    },
  },
}
