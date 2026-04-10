return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    tag = "3.39.0",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "echasnovski/mini.icons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      {
        "<leader>n",
        "<cmd>Neotree source=filesystem reveal=true position=left toggle=true<cr>",
        desc = "Nvim-Tree Toggle",
      },
    },
    opts = {
      -- source_selector = {
      --   winbar = true,
      -- },
      default_component_configs = {
        git_status = {
          symbols = {
            -- Change type
            added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
            deleted = "✖", -- this can only be used in the git_status source
            renamed = "", -- this can only be used in the git_status source
            -- Status type
            untracked = "?",
            ignored = "",
            unstaged = "u",
            staged = "s",
            conflict = "",
          },
        },
        diagnostics = {
          symbols = {
            hint = "⚑",
            info = "",
            warn = "▲",
            error = "✘",
          },
          highlights = {
            hint = "DiagnosticSignHint",
            info = "DiagnosticSignInfo",
            warn = "DiagnosticSignWarn",
            error = "DiagnosticSignError",
          },
        },
        icon = {
          provider = function(icon, node) -- setup a custom icon provider
            local text, hl
            local mini_icons = require("mini.icons")
            if node.type == "file" then -- if it's a file, set the text/hl
              text, hl = mini_icons.get("file", node.name)
            elseif node.type == "directory" then -- get directory icons
              text, hl = mini_icons.get("directory", node.name)
              -- only set the icon text if it is not expanded
              if node:is_expanded() then text = nil end
            end

            -- set the icon text/highlight only if it exists
            if text then icon.text = text end
            if hl then icon.highlight = hl end
          end,
        },
        kind_icon = {
          provider = function(icon, node)
            local mini_icons = require("mini.icons")
            icon.text, icon.highlight = mini_icons.get("lsp", node.extra.kind.name)
          end,
        },
      },
      filesystem = {
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        filtered_items = {
          hide_gitignored = false,
        },
      },
      buffers = {
        follow_current_file = { enabled = true },
      },
      window = {
        mappings = {
          -- remap (m)ove to (mv)ove
          ["m"] = "none",
          ["mv"] = "move",
          -- remove "e"
          ["e"] = "none",
          ["C-m"] = "none",
          ["O"] = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            if node.type == "directory" then
              vim.cmd("edit " .. path)
            else
              print("Not a directory")
            end
          end,
        },
      },
    },
  },
}
