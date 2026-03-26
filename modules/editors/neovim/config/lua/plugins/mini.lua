return {
  {
    'echasnovski/mini.nvim',
    config = function()
      -- icons
      require('mini.icons').setup({
        filetype = {
          cucumber = { glyph = require('mini.icons').get('file', 'CHANGELOG.md') },
        },
      })

      -- git
      require('mini.git').setup()
      vim.keymap.set({ 'n', 'x' }, '<Leader>gs', '<Cmd>lua MiniGit.show_at_cursor()<CR>', { desc = 'Show at cursor' })
      vim.keymap.set({ 'n' }, '<Leader>gb', '<Cmd>vertical Git blame -- %<CR>', { desc = 'Git blame' })
      local align_blame = function(au_data)
        if au_data.data.git_subcommand ~= 'blame' then return end

        -- Align blame output with source
        local win_src = au_data.data.win_source
        vim.wo.wrap = false
        vim.fn.winrestview({ topline = vim.fn.line('w0', win_src) })
        vim.api.nvim_win_set_cursor(0, { vim.fn.line('.', win_src), 0 })

        -- Bind both windows so that they scroll together
        vim.wo[win_src].scrollbind, vim.wo.scrollbind = true, true
      end

      local au_opts = { pattern = 'MiniGitCommandSplit', callback = align_blame }
      vim.api.nvim_create_autocmd('User', au_opts)

      require('mini.diff').setup()
      vim.keymap.set({ 'n' }, ']c', '<Cmd>lua MiniDiff.goto_hunk("next", {wrap=true})<CR>',
        { desc = 'Goto next change/hunk (GIT)' })
      vim.keymap.set({ 'n' }, '[c', '<Cmd>lua MiniDiff.goto_hunk("prev", {wrap=true})<CR>',
        { desc = 'Goto prev change/hunk (GIT)' })
      vim.keymap.set({ 'n' }, '<Leader>gp', '<Cmd>lua MiniDiff.toggle_overlay()<CR>',
        { desc = 'Preview buffer changes (GIT)' })

      -- code commenting
      require('mini.comment').setup()

      -- highlight word under cursor
      require('mini.cursorword').setup({ delay = 400 })

      -- remove buffers retaining window layout
      require('mini.bufremove').setup()
      vim.keymap.set("n", "<M-x>", "<cmd>lua require('mini.bufremove').delete()<cr>", { desc = 'Delete Buffer' })

      -- smart aligning
      require('mini.align').setup()

      -- status bar
      require('mini.statusline').setup()
      local f = function(args) vim.b[args.buf].ministatusline_disable = true end
      vim.api.nvim_create_autocmd('Filetype', { pattern = 'neo-tree', callback = f })

      -- notify
      require('mini.notify').setup()
      --
      -- auto pairs
      require('mini.pairs').setup()

      -- surround actions (saiw etc)
      require('mini.surround').setup()

      -- todo comments
      local hi_words = require('mini.extra').gen_highlighter.words
      require('mini.hipatterns').setup({
        highlighters = {
          todo = hi_words({ 'TODO', 'Todo', 'todo' }, 'MiniHipatternsTodo'),
        },
      })
    end
  }
}
