return {
  {
    "stevearc/aerial.nvim",
    opts = {
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
      end,
      disable_max_lines = 0,
      layout = {
        resize_to_content = false,
      },
    },
    keys = { -- Example mapping to toggle outline
      { "<leader>ol", "<cmd>AerialToggle!<CR>", desc = "Toggle outline" },
    },
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.icons",
    },
  },
}
