return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
          require('treesitter-context').setup({
            separator = "┈",
          })
          vim.keymap.set('n', '<leader>c', require("treesitter-context").go_to_context)
          -- vim.cmd [[ hi! def link TreesitterContext LspInlayHint ]]
          -- vim.cmd [[ hi TreesitterContext gui=italic ]]
        end
      },
      {
        "andymass/vim-matchup",
        init = function()
          vim.g.matchup_text_obj_enabled = 0
        end
      },
    },
    build = ':TSUpdate',
    config = function()
      require 'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all"
        ensure_installed = {
          'bash',
          'c',
          'comment',
          'cpp',
          'css',
          'csv',
          'dockerfile',
          'git_config',
          'git_rebase',
          'gitattributes',
          'gitcommit',
          'gitignore',
          'go',
          'gomod',
          'gosum',
          'gotmpl',
          'gowork',
          'graphql',
          'hcl',
          'html',
          'http',
          'javascript',
          'jsdoc',
          'json',
          'lua',
          'make',
          'markdown',
          'markdown_inline',
          'proto',
          'python',
          'regex',
          'sql',
          'toml',
          'tsx',
          'typescript',
          'vim',
          'xml',
          'yaml'
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- List of parsers to ignore installing (for "all")
        -- ignore_install = { "javascript" },

        highlight = {
          -- `false` will disable the whole extension
          enable = true,
          -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
          -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
          -- the name of the parser)
          -- list of language that will be disabled
          -- disable = { "c", "rust" },

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false
        },

        indent = { enable = true },
        -- incremental_selection = {
        --   enable = true,
        --   keymaps = {
        --     init_selection = '<c-space>',
        --     node_incremental = '<c-space>',
        --     scope_incremental = '<c-s>',
        --     node_decremental = '<M-space>',
        --   },
        -- },

      }
    end
  }
}
