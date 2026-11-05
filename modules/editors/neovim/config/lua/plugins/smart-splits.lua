return {
  {
    "smart-splits-nvim/smart-splits.nvim",
    version = "^3.0.0",
    dependencies = {
      {
        "smart-splits-nvim/backend-tmux",
        main = "smart-splits-backend-tmux",
        opts = {
          --[[ backend-specific options go here ]]
        },
      },
      {
        "sfrieds3/smart-splits-backend-rex",
        version = "^0.2.0",
      },
    },
    opts = {
      -- tmux first, so nvim inside tmux inside Rex moves between tmux panes
      mux = { backend = { "smart-splits-backend-tmux", "smart-splits-backend-rex" } },
    },
    keys = {
      {
        "<M-m>",
        mode = "n",
        function() require("smart-splits").move_cursor_left() end,
        desc = "Move to window left",
      },
      {
        "<M-n>",
        mode = "n",
        function() require("smart-splits").move_cursor_down() end,
        desc = "Move to window down",
      },
      {
        "<M-e>",
        mode = "n",
        function() require("smart-splits").move_cursor_up() end,
        desc = "Move to window up",
      },
      {
        "<M-i>",
        mode = "n",
        function() require("smart-splits").move_cursor_right() end,
        desc = "Move to window right",
      },
    },
  },
}
