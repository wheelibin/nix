-- ── Icons ─────────────────────────────────────────────────────────────────────

local function setup_icons()
  require('mini.icons').setup({
    filetype = {
      -- cucumber lacks a built-in icon; reuse the changelog glyph as a stand-in
      cucumber = { glyph = require('mini.icons').get('file', 'CHANGELOG.md') },
    },
  })
  -- Prepend LSP kind icons (e.g. in completion menus) with mini.icons glyphs
  MiniIcons.tweak_lsp_kind('prepend')
end

-- ── Git (mini.git + mini.diff) ────────────────────────────────────────────────

local function setup_git()
  require('mini.git').setup()
  vim.keymap.set({ 'n', 'x' }, '<Leader>gs', '<Cmd>lua MiniGit.show_at_cursor()<CR>', { desc = 'Show at cursor' })
  vim.keymap.set({ 'n' }, '<Leader>gb', '<Cmd>vertical Git blame -- %<CR>', { desc = 'Git blame' })

  -- When a blame split opens, align it to the same scroll position as the source window
  local align_blame = function(au_data)
    if au_data.data.git_subcommand ~= 'blame' then return end
    local win_src = au_data.data.win_source
    vim.wo.wrap = false
    vim.fn.winrestview({ topline = vim.fn.line('w0', win_src) })
    vim.api.nvim_win_set_cursor(0, { vim.fn.line('.', win_src), 0 })
    -- Bind both windows so they scroll together
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

-- ── Editing helpers ───────────────────────────────────────────────────────────

local function setup_editing()
  require('mini.comment').setup()
  require('mini.align').setup()
  require('mini.surround').setup()
  require('mini.pairs').setup()

  require('mini.bufremove').setup()
  vim.keymap.set('n', '<M-x>', "<cmd>lua require('mini.bufremove').delete()<cr>", { desc = 'Delete Buffer' })
end

-- ── UI / Visual ───────────────────────────────────────────────────────────────

local function setup_ui()
  -- Statusline (disable in neo-tree sidebars where it clutters the panel)
  require('mini.statusline').setup()
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'neo-tree',
    callback = function(args) vim.b[args.buf].ministatusline_disable = true end,
  })

  -- Notifications + cursor-word highlight

  -- notify in bottom-right
  local win_config = function()
    local has_statusline = vim.o.laststatus > 0
    local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
    return { anchor = 'SE', col = vim.o.columns, row = vim.o.lines - pad }
  end
  require('mini.notify').setup({ window = { config = win_config } })

  require('mini.cursorword').setup({ delay = 400 })

  -- Highlight TODO/todo comments in all buffers
  local hi_words = require('mini.extra').gen_highlighter.words
  require('mini.hipatterns').setup({
    highlighters = {
      todo = hi_words({ 'TODO', 'Todo', 'todo' }, 'MiniHipatternsTodo'),
    },
  })

  -- Indent scope line (exponential animation, muted Kanagawa color)
  require('mini.indentscope').setup()
  MiniIndentscope.config.draw.animation = MiniIndentscope.gen_animation.none()
  vim.api.nvim_set_hl(0, 'MiniIndentscopeSymbol', { fg = '#727169' }) -- Kanagawa fujiGray

  -- Start screen
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

-- ── Completion + Snippets ─────────────────────────────────────────────────────

local function setup_completion()
  local gen_loader = require('mini.snippets').gen_loader
  require('mini.snippets').setup({
    snippets = { gen_loader.from_lang() },
  })
  MiniSnippets.start_lsp_server()

  -- Stop any active snippet session when leaving insert/select mode,
  -- rather than only at the final $0 tabstop (mini.snippets default)
  vim.api.nvim_create_autocmd('ModeChanged', {
    pattern = 'i*:n',
    callback = function() MiniSnippets.session.stop() end,
  })

  require('mini.completion').setup()
  vim.opt.completeopt = { 'menuone', 'noinsert', 'fuzzy' }

  -- Disable completion in picker prompt buffers (fzf-lua, fff, etc.) where
  -- the built-in popup would interfere with the picker UI
  vim.api.nvim_create_autocmd({ 'BufEnter', 'FileType' }, {
    callback = function(args)
      local bt = vim.bo[args.buf].buftype
      local ft = vim.bo[args.buf].filetype
      if bt == 'prompt' or ft == 'fff' then
        vim.b[args.buf].minicompletion_disable = true
      end
    end,
  })
end

-- ── Keymaps ───────────────────────────────────────────────────────────────────

local function setup_keymap()
  local map_multistep = require('mini.keymap').map_multistep

  -- Smart insert-mode keys composing mini.completion, mini.snippets, mini.pairs.
  -- <Tab>/<S-Tab> also cover Select mode ('s') since mini.snippets puts the
  -- cursor in Select mode at each tabstop.
  map_multistep({ 'i', 's' }, '<Tab>', { 'minisnippets_next', 'minisnippets_expand', 'pmenu_next' })
  map_multistep({ 'i', 's' }, '<S-Tab>', { 'minisnippets_prev', 'pmenu_prev' })
  map_multistep('i', '<CR>', { 'pmenu_accept', 'minipairs_cr' })
  map_multistep('i', '<BS>', { 'minipairs_bs' })
end

-- ── Plugin spec ───────────────────────────────────────────────────────────────

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
      setup_keymap()
    end,
  },
}
