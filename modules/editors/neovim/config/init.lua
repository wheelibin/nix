require("options")

-- bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins", {
  lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json",
})

-- Ensure nix-installed packages (e.g. the treesitter grammars Home Manager
-- writes to `stdpath('data')/site/pack/hm`) are on the packpath, then load
-- them. This must run AFTER `lazy.setup()` because lazy.nvim resets packpath
-- during setup. On macOS the default packpath also omits
-- `~/.local/share/nvim/site`, so without this the parsers exist on disk but
-- are never discovered by `vim.treesitter`.
vim.opt.packpath:prepend(vim.fn.stdpath("data") .. "/site")
vim.cmd("packloadall")

require("keys")
require("autocommands")
