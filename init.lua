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
    {"nvim-telescope/telescope.nvim",
    dependencies = { 'nvim-lua/plenary.nvim'}
},
{ "folke/noice.nvim", config = function() require("noice").setup() end, dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify", }
    },
    { 'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons', -- optional, for file icons
}, config = function() require('nvim-tree').setup {
    update_focused_file = {
        enable = true,
        update_root = false
    }
} end },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()

        end
    },
    {
        "williamboman/mason-lspconfig.nvim"
    },
{"neovim/nvim-lspconfig", config = function()
        local lspconfig = require('lspconfig')

        lspconfig.jdtls.setup {
            root_dir = lspconfig.util.root_pattern(
                "pom.xml",
                "mvnw",
                ".git"
            ),
            settings = {
                java = {
                    maven = {
                        downloadSources = true,
                    },
                },
            },
        }

        -- TypeScript Language Server
        lspconfig.tsserver.setup {}

        -- Angular Language Server
        lspconfig.angularls.setup {
            cmd = { "ngserver", "--stdio" },
            filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
            root_dir = lspconfig.util.root_pattern("angular.json", ".git"),
}

    end }
}

-- LSP keymaps
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Find References" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- Plugin setup using Lazy.nvim
require("lazy").setup(plugins)


vim.api.nvim_set_keymap("n", "<F5>", ":!gcc % -o %< && .\\%< <CR>", { noremap = true, silent = true })

local builtin = require("telescope.builtin")

require("telescope").setup({
    defaults = {
        path_display = { "truncate" },
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {
                width = 0.95,
                height = 0.90,
                preview_width = 0.50,
            },
        },
    },
})

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>lg", builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>bb", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>rf", builtin.oldfiles, { desc = "Recent files" })

-- Set the theme
vim.cmd("colorscheme catppuccin-mocha")


vim.api.nvim_set_keymap('i','jk','<Esc>',{ noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<leader>s', '/', { noremap = true, silent = false })

--enable smartcase for searching
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.smartindent = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

vim.opt.clipboard = "unnamedplus"

vim.opt.scrolloff = 3

vim.keymap.set("n", "<leader>w", ":write<CR>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", ":quit<CR>", { desc = "Quit" })

vim.keymap.set("n", "<leader>cr", [[:%s/\r//g<CR>]], {
    desc = "Remove carriage returns"
})

--TreeSitter


--NVIM-TREE
--Move between file tree and editor using C-w then h or l
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

