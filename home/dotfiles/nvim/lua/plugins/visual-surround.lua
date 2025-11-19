return {
  {
    "NStefan002/visual-surround.nvim",
    config = function()
      require("visual-surround").setup({
        -- surround_chars = { "{", "}", "[", "]", "(", ")", "'", '"', "`" }
      })
    end,
  }
}
