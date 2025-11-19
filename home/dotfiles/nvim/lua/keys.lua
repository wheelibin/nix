-- buffer switching
vim.keymap.set("n", '<bs>', '<C-^>', { desc = 'Edit alternative file' })

-- windows
vim.keymap.set("n", '<M-q>', ':wincmd q<CR>', { desc = 'Close current window' })

vim.keymap.set("n", '<M-S-m>', ':wincmd v<CR>:wincmd h<CR>', { desc = 'New window left' })
vim.keymap.set("n", '<M-S-n>', ':wincmd s<CR>', { desc = 'New window below' })
vim.keymap.set("n", '<M-S-e>', ':wincmd s<CR>:wincmd k<CR>', { desc = 'New window above' })
vim.keymap.set("n", '<M-S-i>', ':wincmd v<CR>', { desc = 'New window right' })

-- resize windows
vim.keymap.set("n", '<M-S-m>', ':5wincmd ><CR>', { desc = 'Make window narrower' })
vim.keymap.set("n", '<M-S-k>', ':5wincmd <<CR>', { desc = 'Make window wider' })

-- move lines
vim.keymap.set("n", '<C-up>', ':m .-2<CR>==', { desc = 'Move line up' })
vim.keymap.set("i", '<C-up>', '<Esc>:m .-2<CR>==gi', { desc = 'Move line up' })
vim.keymap.set("v", '<C-up>', ':m \'<-2<CR>gv=gv', { desc = 'Move line up' })
vim.keymap.set("n", '<C-down>', ':m .+1<CR>==', { desc = 'Move line up' })
vim.keymap.set("i", '<C-down>', '<Esc>:m .+1<CR>==gi', { desc = 'Move line up' })
vim.keymap.set("v", '<C-down>', ':m \'>+1<CR>gv=gv', { desc = 'Move line up' })

vim.keymap.set("n", "<leader>tn", ":tabnext<CR>", { desc = "Tab next" })

vim.keymap.set('n', ';', ':')
vim.keymap.set('n', ':', ';')

-- Remap for dealing with word wrap
--vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })
--vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })

--- center in page nav
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set('n', '<C-p>', '"0p')
vim.keymap.set('n', '<C-P>', '"0P')
vim.keymap.set('v', '<C-p>', '"0p')
vim.keymap.set('v', '<C-P>', '"0P')

-- jump to next search (+centering)
-- vim.keymap.set('', 'n', 'nzzzv', {})
-- vim.keymap.set('', 'N', 'Nzzzv', {})

vim.keymap.set('n', '<leader><bs>', ':noh<CR>', { desc = 'Clear search highlighting' })

-- format json with jq
vim.keymap.set('v', '<leader>jq', ':!jq<CR>')

-- misc / utils
---------------
local oid = require("objectid")

vim.keymap.set("n", "<leader>go", function()
  vim.api.nvim_put({ oid.generate_object_id() }, 'c', true, true)
end, { desc = "Insert MongoDB ObjectId" })
---------------

-- Overrides for Colemak-DH
--------------------------
-- remap hjkl to colemak homerow equivalents
vim.keymap.set('', 'm', 'h', {})
vim.keymap.set('', 'n', 'j', {})
vim.keymap.set('', 'e', 'k', {})
vim.keymap.set('', 'i', 'l', {})

-- now we need to remap the keys we took for hjkl
-- move insert at cursor to o
vim.keymap.set('', 'o', 'i', {})
vim.keymap.set('', 'O', 'I', {})
-- now we need to move o, so h seems good as it's "below" so is fairly logical
vim.keymap.set('', 'h', 'o', {})
vim.keymap.set('', 'H', 'O', {})

-- jump to next search (+centering)
vim.keymap.set('', 'k', 'nzzzv', {})
vim.keymap.set('', 'K', 'Nzzzv', {})

-- move to end of next word
vim.keymap.set('', 'l', 'e', {})
--------------------------
