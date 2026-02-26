return {
  {
    'mrjones2014/smart-splits.nvim',
    build = './kitty/install-kittens.bash',
    lazy = true,
    keys = {
      { "<M-m>", mode = "n", function() require('smart-splits').move_cursor_left() end,  desc = "Move to window left" },
      { "<M-n>", mode = "n", function() require('smart-splits').move_cursor_down() end,  desc = "Move to window down" },
      { "<M-e>", mode = "n", function() require('smart-splits').move_cursor_up() end,    desc = "Move to window up" },
      { "<M-i>", mode = "n", function() require('smart-splits').move_cursor_right() end, desc = "Move to window right" },
    }
  }
}
