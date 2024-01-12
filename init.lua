local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

require("lazy").setup({
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},
      {'neovim/nvim-lspconfig'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/nvim-cmp'},
      {'L3MON4D3/LuaSnip'},
    }
  },

  {
    "overcache/NeoSolarized",
    dependencies = {
      "tjdevries/colorbuddy.nvim",
    }
  },

  "rstacruz/vim-closer",

  'andymass/vim-matchup',

  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },

  {
    'nvim-telescope/telescope.nvim', tag = '0.1.4',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'BurntSushi/ripgrep'
    }
  },

  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },

  'tpope/vim-fugitive',
  'tpope/vim-surround',
  'justinmk/vim-sneak',
}, opts)

-- <Space> is <Leader>
vim.g.mapleader = ' '

-- Main config
vim.opt.clipboard = 'unnamed' -- yank goes to clipboard
vim.opt.number = true -- display line numbers
vim.opt.rnu = true -- relative line numbers
vim.opt.autoindent = true -- copy indent from prev line
vim.opt.tabstop = 2 -- set tab to 2 spaces
vim.opt.shiftwidth = 2 -- set '>>' and '<<' spacing indent
vim.opt.ignorecase = true -- ignore case in search
vim.opt.hlsearch = true -- highlight all search matches
vim.opt.smartcase = true -- pay attention to case when caps are used
vim.opt.incsearch = true -- show search results as I type
vim.opt.ttimeoutlen = 100 -- decrease timeout for faster insert with 'O'
vim.opt.ruler = true -- show row and column in footer
vim.opt.scrolloff = 2 -- minimum lines above/below cursor
vim.opt.laststatus = 2 -- always show status bar
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.listchars = 'tab:»·,nbsp:·,trail:·,extends:>,precedes:<'
vim.opt.list = true -- display unprintable characters
vim.opt.cursorline = true -- highlight current line
vim.opt.termguicolors = true
vim.opt.mouse = ''
vim.opt.colorcolumn = '80,107'
vim.opt.background = 'light'

-- persistent undo
vim.opt.undodir = '/Users/andfalk/.local/share/nvim/undo'
vim.opt.undofile = true

-- Auto-removal of trailing whitespaces on save
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*' },
  command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { '*.yaml.gotmpl' },
  command = 'setfiletype yaml'
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { 'seed_jenkins', 'Jenkinsfile' },
  command = 'setfiletype groovy'
})

-- vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
--   pattern = { '*.py' },
--   command = ':%!black --stdin-filename % -q - 2>/dev/null',
-- })

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { '*.py' },
  command = 'set colorcolumn=88,107'
})

function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

function vmap(shortcut, command)
  map('v', shortcut, command)
end

function cmap(shortcut, command)
  map('c', shortcut, command)
end

function tmap(shortcut, command)
  map('t', shortcut, command)
end

nmap('<Leader>b', '<CMD>Telescope buffers<CR>')
nmap('<Leader>f', '<CMD>Telescope live_grep<CR>')
nmap('<Leader>p', '<CMD>Telescope find_files<CR>')
nmap('<F3>', '<CMD>noh<CR>')
imap('<F3>', '<CMD>noh<CR>')
nmap('<F4>', '<CMD>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>')
imap('<F4>', '<CMD>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>')
nmap('<F5>', '<CMD>%!black --stdin-filename % -q - 2>/dev/null<CR>')

vim.cmd('colorscheme NeoSolarized')

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'ansiblels',
    -- 'groovyls',
    'pyright',
    'terraformls',
    'yamlls'
  },
  handlers = {
    lsp_zero.default_setup,
  },
})

require('lspconfig').yamlls.setup({
  settings = {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/chart.json"] = "Chart.yaml",
        ["https://json.schemastore.org/helmfile.json"] = "helmfile.yaml",
      }
    }
  }
})

lsp_zero.setup()
