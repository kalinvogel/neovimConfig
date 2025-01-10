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
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    {"catppuccin/nvim",name = "catppuccin"},
    {"nvim-telescope/telescope.nvim",tag = '0.1.8', 
    dependencies = { 'nvim-lua/plenary.nvim'}
},
{ "folke/noice.nvim", config = function() require("noice").setup() end, dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify", }
    },
    { 'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons', -- optional, for file icons
}, config = function() require('nvim-tree').setup {} end }
}

-- Plugin setup using Lazy.nvim
require("lazy").setup(plugins)


vim.api.nvim_set_keymap("n", "<F5>", ":!gcc % -o %< && .\\%< <CR>", { noremap = true, silent = true })

local builtin = require("telescope.builtin")
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { noremap = true, silent = true }) 
vim.api.nvim_set_keymap('n', '<leader>lg', '<cmd>Telescope live_grep<cr>', { noremap = true, silent = true }) 
vim.api.nvim_set_keymap('n', '<leader>bb', '<cmd>Telescope buffers<cr>', { noremap = true, silent = true })  
vim.api.nvim_set_keymap('n', '<leader>rf', '<cmd>Telescope oldfiles<cr>', { noremap = true, silent = tru})

-- Set the theme
vim.cmd("colorscheme catppuccin-mocha")


vim.api.nvim_set_keymap('i','jk','<Esc>',{ noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<leader>s', '/', { noremap = true, silent = false })

--enable smartcase for searching
vim.opt.smartcase = true

vim.opt.autoindent = true

vim.opt.clipboard = "unnamedplus"

--TreeSitter


--NVIM-TREE
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })



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

