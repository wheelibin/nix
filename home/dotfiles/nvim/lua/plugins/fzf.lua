return {
  {
    "ibhagwan/fzf-lua",
    lazy = true,
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- calling `setup` is optional for customization
      local actions = require "fzf-lua.actions"
      require("fzf-lua").setup({
        oldfiles = {
          prompt                  = 'History❯ ',
          cwd_only                = true,
          -- stat_file         = true,         -- verify files exist on disk
          -- -- can also be a lua function, for example:
          -- -- stat_file = require("fzf-lua").utils.file_is_readable,
          -- -- stat_file = function() return true end,
          include_current_session = true, -- include bufs from current session
        },
        grep = {
          -- rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
          actions = {
            -- actions inherit from 'actions.files' and merge
            -- this action toggles between 'grep' and 'live_grep'
            ["ctrl-g"] = { actions.grep_lgrep },
            ["ctrl-i"] = { actions.toggle_ignore },
            ["ctrl-h"] = { actions.toggle_hidden },
          },
        },
      })
    end,
    keys = {
      {
        "<leader>ff",
        mode = "n",
        function() require('fzf-lua').files({ path_shorten = 8 }) end,
        desc = "Find files"
      },
      {
        "<leader>fo",
        mode = "n",
        function() require('fzf-lua').oldfiles({ path_shorten = 8 }) end,
        desc = "Find previously opened files"
      },
      {
        "<leader>fa",
        mode = "n",
        function() require('fzf-lua').live_grep_native({ path_shorten = 8 }) end,
        desc = "Find text (grep)"
      },
      {
        "<leader><space>",
        mode = "n",
        function() require('fzf-lua').buffers({ path_shorten = 8 }) end,
        desc = "Find buffers"
      },
      {
        "<leader>fr",
        mode = "n",
        function() require('fzf-lua').lsp_references() end,
        desc = "Find references (LSP)"
      },
      {
        "<leader>fe",
        mode = "n",
        function() require('fzf-lua').diagnostics_workspace() end,
        desc = "Find errors (diagnostics) (LSP)"
      },
      {
        "<leader>fs",
        mode = "n",
        function() require('fzf-lua').lsp_live_workspace_symbols() end,
        desc = "Find symbols (LSP)"
      },
      {
        "<leader>ds",
        mode = "n",
        function() require('fzf-lua').lsp_document_symbols() end,
        desc = "Find document symbols (LSP)"
      },
      {
        "gi",
        mode = "n",
        function() require('fzf-lua').lsp_implementations() end,
        desc = "Find implementations (LSP)"
      },
      -- {
      --   "gd",
      --   mode = "n",
      --   function() require('fzf-lua').lsp_definitions() end,
      --   desc = "Find definitions (LSP)"
      -- },
      {
        "<leader>fh",
        mode = "n",
        function() require('fzf-lua').git_bcommits() end,
        desc = "File history (git)"
      },
      {
        "<leader>fc",
        mode = "n",
        function() require('fzf-lua').git_commits() end,
        desc = "Find Commits (git)"
      },
      {
        "<leader>fw",
        mode = "n",
        function() require('fzf-lua').grep_cword() end,
        desc = "Find word under cursor"
      },
      {
        "<leader>fw",
        mode = "v",
        function() require('fzf-lua').grep_visual() end,
        desc = "Find selection"
      },
      {
        "<leader>re",
        mode = "n",
        function() require('fzf-lua').registers() end,
        desc = "View registers"
      },
      {
        "<leader>tr",
        mode = "n",
        function() require('fzf-lua').resume() end,
        desc = "Telescope resume"
      },
      {
        "<leader>fm",
        mode = "n",
        function() require('fzf-lua').keymaps() end,
        desc = "Find keymaps"
      },
      {
        "<leader>ft",
        mode = "n",
        function() require('fzf-lua').colorschemes() end,
        desc = "Find themes (colorschemes)"
      },
      {
        "<leader>ca",
        mode = "n",
        function() require('fzf-lua').lsp_code_actions() end,
        desc = "Code Actions (LSP)"
      },
      -- {
      --   "<leader>d",
      --   mode = "n",
      --   function() require('fzf-lua').dap_commands() end,
      --   desc = "Debug (DAP)"
      -- },
      {
        "<leader>/",
        mode = "n",
        function() require('fzf-lua').lgrep_curbuf() end,
        desc = "Fuzzy find in current buffer"
      },
      {
        "<leader>gb",
        mode = "n",
        function() require('fzf-lua').git_blame() end,
        desc = "Git Blame (git)"
      },

      -- {
      --   "<leader>/",
      --   mode = "n",
      --   function() require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false, }) end,
      --   desc = "Fuzzy find in current buffer"
      -- },
      -- {
      --   "<leader>ch",
      --   mode = "n",
      --   require('telescope.builtin').command_history,
      --   desc = "Command History"
      -- },
      --
    }
  }
}
