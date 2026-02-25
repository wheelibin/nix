return {
  {
    "aaronik/treewalker.nvim",
    lazy = true,
    event = "BufEnter",
    opts = {
      highlight = true -- default is false
    },
    keys = {
      { "<C-n>", ":Treewalker Down<CR>", mode = { 'n' } },
      { "<C-e>", ":Treewalker Up<CR>",   mode = { 'n' } },
    },
  }
}
