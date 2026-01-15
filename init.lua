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

-- <Space> is <Leader>
vim.g.mapleader = ' '

require("lazy").setup({
  spec = {
    {
      "mason-org/mason-lspconfig.nvim",
      opts = {},
      dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
      },
    },
    {
      'L3MON4D3/LuaSnip',
      dependencies = {
        { 'rafamadriz/friendly-snippets' },
      },
    },
    {
      'hrsh7th/nvim-cmp',
      version = false,
      dependencies = {
        { 'hrsh7th/cmp-buffer' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'hrsh7th/cmp-nvim-lsp' },
      },
      opts = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')

        return {
          preselect = cmp.PreselectMode.None,
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          sources = cmp.config.sources({
            { name = "buffer" },
            { name = 'luasnip' },
            { name = 'nvim_lsp' },
          }),
          mapping = cmp.mapping.preset.insert({
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = false }),
            ["<Tab>"] = cmp.mapping(function(fallback)
              if luasnip.locally_jumpable(1) then
                luasnip.jump(1)
              else
                fallback()
              end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
              if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { "i", "s" }),
          }),
        }
      end,
    },
    {
      "overcache/NeoSolarized",
      dependencies = {
        "tjdevries/colorbuddy.nvim",
      }
    },
    { "rstacruz/vim-closer" },
    { "andymass/vim-matchup" },
    { 'numToStr/Comment.nvim' },
    {
      'nvim-telescope/telescope.nvim',
      tag = 'v0.1.9',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'BurntSushi/ripgrep'
      }
    },
    {
      'lewis6991/gitsigns.nvim',
      config = function()
        require('gitsigns').setup{
          on_attach = function(bufnr)
            local gitsigns = require('gitsigns')

            local function map(mode, l, r, opts)
              opts = opts or {}
              opts.buffer = bufnr
              vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map('n', ']c', function()
              if vim.wo.diff then
                vim.cmd.normal({']c', bang = true})
              else
                gitsigns.nav_hunk('next')
              end
            end)

            map('n', '[c', function()
              if vim.wo.diff then
                vim.cmd.normal({'[c', bang = true})
              else
                gitsigns.nav_hunk('prev')
              end
            end)
          end
        }
      end
    },

    { 'tpope/vim-fugitive' },
    { 'tpope/vim-surround' },
    { 'justinmk/vim-sneak' },
    { 'nvim-treesitter/nvim-treesitter' },
    { 'wsdjeg/vim-fetch' },
  }
})

require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
  }
})
-- Main config
-- yank goes to clipboard
if vim.loop.os_uname().sysname == "Linux" then
  vim.opt.clipboard = 'unnamedplus'
elseif vim.loop.os_uname().sysname == "Darwin" then
  vim.opt.clipboard = 'unnamed'
end
vim.opt.number = true         -- display line numbers
vim.opt.rnu = true            -- relative line numbers
vim.opt.autoindent = true     -- copy indent from prev line
vim.opt.smartindent = true
vim.opt.tabstop = 2           -- set tab to 2 spaces
vim.opt.shiftwidth = 2        -- set '>>' and '<<' spacing indent
vim.opt.ignorecase = true     -- ignore case in search
vim.opt.hlsearch = true       -- highlight all search matches
vim.opt.smartcase = true      -- pay attention to case when caps are used
vim.opt.incsearch = true      -- show search results as I type
vim.opt.ttimeoutlen = 100     -- decrease timeout for faster insert with 'O'
vim.opt.ruler = true          -- show row and column in footer
vim.opt.scrolloff = 2         -- minimum lines above/below cursor
vim.opt.laststatus = 2        -- always show status bar
vim.opt.expandtab = true      -- use spaces instead of tabs
vim.opt.listchars = 'tab:»·,nbsp:·,trail:·,extends:>,precedes:<'
vim.opt.list = true           -- display unprintable characters
vim.opt.cursorline = true     -- highlight current line
vim.opt.termguicolors = true
vim.opt.mouse = ''
vim.opt.colorcolumn = '80,107'
vim.opt.splitright = true
-- vim.opt.complete = ''

-- persistent undo
vim.opt.undodir = os.getenv('HOME') .. '/.local/share/nvim/undo'
vim.opt.undofile = true

-- vim.g.sneak = 1

-- Auto-removal of trailing whitespaces on save
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*' },
  command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { '*.yaml.gotmpl', '*.bu' },
  command = 'setfiletype yaml'
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { 'seed_jenkins', 'Jenkinsfile*' },
  command = 'setfiletype groovy'
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { '*.py' },
  command = 'set colorcolumn=88,107'
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { '*.go' },
  command = 'set noexpandtab | set tabstop=2 | set shiftwidth=2 | set listchars=tab:‣·,nbsp:·,trail:·,extends:>,precedes:<'
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
nmap('<F3>', '<CMD>lua vim.lsp.buf.code_action()<CR>')
imap('<F3>', '<CMD>lua vim.lsp.buf.code_action()<CR>')
nmap('<F6>', '<CMD>noh<CR>')
imap('<F6>', '<CMD>noh<CR>')
-- nmap('<F7>', '<CMD>LspStop<CR>')
-- imap('<F7>', '<CMD>LspStop<CR>')
-- nmap('<F8>', '<CMD>LspStart<CR>')
-- imap('<F8>', '<CMD>LspStart<CR>')
nmap('<F12>', '<CMD>vertical Git<CR>')
imap('<F12>', '<CMD>vertical Git<CR>')

vim.cmd('colorscheme NeoSolarized')
-- vim.cmd('highlight Normal guibg=none')
-- vim.cmd('colorscheme darkblue')
vim.opt.background = 'light'


require('luasnip.loaders.from_vscode').lazy_load()

-- require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    -- 'ansiblels',
    -- 'bashls',
    -- 'dockerls',
    -- 'lua_ls',
    'gopls',
    'marksman',
    -- 'pyright',
    -- 'terraformls',
    -- 'yamlls'
  },
})

-- vim.lsp.config('yamlls', {
--   settings = {
--     yaml = {
--       schemas = {
--         ["https://raw.githubusercontent.com/SchemaStore/schemastore/master/src/schemas/json/helmfile.json"] = "helmfile.yaml",
--         ["https://raw.githubusercontent.com/SchemaStore/schemastore/master/src/schemas/json/hchart.json"] = "Chart.yaml"
--       }
--     }
--   }
-- })
--
-- vim.lsp.config('rubocop', {
--   init_options = {
--     safeAutocorrect = false,
--   }
-- })

vim.diagnostic.config({
  virtual_text = {
    current_line = true
  }
})

vim.keymap.set("n", "<space>c", function()
  vim.ui.input({}, function(c)
      if c and c~="" then
        vim.cmd("noswapfile vnew")
        vim.bo.buftype = "nofile"
        vim.bo.bufhidden = "wipe"
        vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.fn.systemlist(c))
      end
  end)
end)
