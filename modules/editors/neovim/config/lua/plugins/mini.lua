local function setup_icons()
  require('mini.icons').setup({
    filetype = {
      cucumber = { glyph = require('mini.icons').get('file', 'CHANGELOG.md') },
    },
  })
  MiniIcons.tweak_lsp_kind('prepend')
end

local function setup_git()
  require('mini.git').setup()
  vim.keymap.set({ 'n', 'x' }, '<Leader>gs', '<Cmd>lua MiniGit.show_at_cursor()<CR>', { desc = 'Show at cursor' })
  vim.keymap.set({ 'n' }, '<Leader>gb', '<Cmd>vertical Git blame -- %<CR>', { desc = 'Git blame' })

  local align_blame = function(au_data)
    if au_data.data.git_subcommand ~= 'blame' then return end
    local win_src = au_data.data.win_source
    vim.wo.wrap = false
    vim.fn.winrestview({ topline = vim.fn.line('w0', win_src) })
    vim.api.nvim_win_set_cursor(0, { vim.fn.line('.', win_src), 0 })
    vim.wo[win_src].scrollbind, vim.wo.scrollbind = true, true
  end
  vim.api.nvim_create_autocmd('User', { pattern = 'MiniGitCommandSplit', callback = align_blame })

  require('mini.diff').setup()
  vim.keymap.set({ 'n' }, ']c', '<Cmd>lua MiniDiff.goto_hunk("next", {wrap=true})<CR>',
    { desc = 'Goto next change/hunk (GIT)' })
  vim.keymap.set({ 'n' }, '[c', '<Cmd>lua MiniDiff.goto_hunk("prev", {wrap=true})<CR>',
    { desc = 'Goto prev change/hunk (GIT)' })
  vim.keymap.set({ 'n' }, '<Leader>gp', '<Cmd>lua MiniDiff.toggle_overlay()<CR>',
    { desc = 'Preview buffer changes (GIT)' })
end

local function setup_editing()
  require('mini.comment').setup()
  require('mini.align').setup()
  require('mini.surround').setup()
  require('mini.pairs').setup()

  require('mini.bufremove').setup()
  vim.keymap.set('n', '<M-x>', "<cmd>lua require('mini.bufremove').delete()<cr>", { desc = 'Delete Buffer' })
end

local function setup_ui()
  require('mini.statusline').setup()
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'neo-tree',
    callback = function(args) vim.b[args.buf].ministatusline_disable = true end,
  })

  require('mini.notify').setup()
  require('mini.cursorword').setup({ delay = 400 })

  local hi_words = require('mini.extra').gen_highlighter.words
  require('mini.hipatterns').setup({
    highlighters = {
      todo = hi_words({ 'TODO', 'Todo', 'todo' }, 'MiniHipatternsTodo'),
    },
  })

  require('mini.indentscope').setup()
  MiniIndentscope.config.draw.animation = MiniIndentscope.gen_animation.exponential({ duration = 10 })
  vim.api.nvim_set_hl(0, 'MiniIndentscopeSymbol', { fg = '#727169' })   -- Kanagawa fujiGray


  local starter = require('mini.starter')
  starter.setup({
    header = table.concat({
      '   ____  ___  ____ _   __(_)___ ___',
      '  / __ \\/ _ \\/ __ \\ | / / / __ `__ \\',
      ' / / / /  __/ /_/ / |/ / / / / / / /',
      '/_/ /_/\\___/\\____/|___/_/_/ /_/ /_/',
    }, '\n'),
    items = { starter.sections.recent_files(10, true) },
    footer = '"Don\'t Panic"',
  })
  vim.api.nvim_set_hl(0, 'MiniStarterHeader', { fg = '#938aa9' }) -- Kanagawa oniViolet
  vim.api.nvim_set_hl(0, 'MiniStarterFooter', { fg = '#727169' }) -- Kanagawa fujiGray
end

local function setup_completion()
  local gen_loader = require('mini.snippets').gen_loader
  require('mini.snippets').setup({
    snippets = { gen_loader.from_lang() },
  })
  MiniSnippets.start_lsp_server()

  -- stop snippet session on any exit to Normal mode (default only stops at $0)
  vim.api.nvim_create_autocmd('ModeChanged', {
    pattern = 'i*:n',
    callback = function() MiniSnippets.session.stop() end,
  })

  require('mini.completion').setup()
  vim.opt.completeopt = { 'menuone', 'noinsert', 'fuzzy' }

  -- disable completion in picker prompt buffers (fzf-lua, fff, etc.)
  vim.api.nvim_create_autocmd({ 'BufEnter', 'FileType' }, {
    callback = function(args)
      local bt = vim.bo[args.buf].buftype
      local ft = vim.bo[args.buf].filetype
      if bt == 'prompt' or ft == 'fff' then
        vim.b[args.buf].minicompletion_disable = true
      end
    end,
  })

  -- confirm completion with <Enter>
  vim.keymap.set('i', '<CR>', function()
    return vim.fn.pumvisible() == 1 and '<C-y>' or '<CR>'
  end, { expr = true, noremap = true })
end

return {
  {
    'echasnovski/mini.nvim',
    dependencies = { 'rafamadriz/friendly-snippets' },
    config = function()
      setup_icons()
      setup_git()
      setup_editing()
      setup_ui()
      setup_completion()
    end,
  },
}
