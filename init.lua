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
vim.g.mapleader = " "

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

local plugins = {
	{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"}
}

-- Plugin setup using Lazy.nvim
require("lazy").setup({
  { "catppuccin/nvim", name = "catppuccin" } ,
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
})


vim.api.nvim_set_keymap("n", "<F5>", ":!gcc % -o %< && .\\%< <CR>", { noremap = true, silent = true })

local builtin = require("telescope.builtin")
vim.keymap.set('n','<C-p>', builtin.find_files,{})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

-- Set the theme
vim.cmd("colorscheme catppuccin-mocha")

vim.api.nvim_set_keymap('i','jk','<Esc>',{ noremap = true, silent = true})

vim.opt.clipboard = "unnamedplus"

--TreeSitter



-- Highlight text on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch", -- You can change this to any highlight group
            timeout = 200,         -- Duration of highlight in milliseconds
        })
    end,
})

