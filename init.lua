--
--
-- PS C:\Users\kalin\AppData\Local\nvim>
--
-- General settings
vim.o.number = true           -- Show line numbers
vim.o.relativenumber = true   -- Show relative line numbers
vim.o.syntax = "on"           -- Enable syntax highlighting
vim.o.tabstop = 4             -- Tab width of 4 spaces
vim.o.shiftwidth = 4          -- Indentation width of 4 spaces
vim.o.expandtab = true        -- Convert tabs to spaces


-- Install lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin setup using Lazy.nvim
require("lazy").setup({
  { "catppuccin/nvim", name = "catppuccin" } ,
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' }
    }
})


local builtin = require("telescope.builtin")
vim.keymap.set('n','<C-p>', builtin.find_files,{})


-- Set the theme
vim.cmd("colorscheme catppuccin-mocha")

vim.api.nvim_set_keymap('i','jk','<Esc>',{ noremap = true, silent = true})

vim.opt.clipboard = "unnamedplus"
