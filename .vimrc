set nocompatible

call plug#begin()
Plug 'kien/ctrlp.vim'

Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-ruby/vim-ruby'

Plug 'tpope/vim-surround'

Plug 'tpope/vim-markdown'

Plug 'slim-template/vim-slim'
Plug 'thoughtbot/vim-rspec'

" Snippets support
Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'

Plug 'bkad/CamelCaseMotion'

Plug 'Townk/vim-autoclose'

" Coloschemes
" Plug 'chriskempson/base16-vim'

Plug 'mileszs/ack.vim'

Plug 'tmhedberg/matchit'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'elixir-lang/vim-elixir'

Plug 'tpope/vim-rails'
Plug 'jgdavey/tslime.vim', { 'branch': 'main' }
Plug 'wsdjeg/vim-fetch'
Plug 'AndrewRadev/splitjoin.vim'

Plug 'hashivim/vim-terraform'
Plug 'easymotion/vim-easymotion'

Plug 'vim-erlang/vim-erlang-runtime'
Plug 'airblade/vim-gitgutter'
Plug 'elzr/vim-json'

Plug '~/go/src/golang.org/x/lint/misc/vim'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'lifepillar/vim-solarized8'
call plug#end()

set rnu
set nu

set backspace=indent,eol,start

set tabstop=2
set expandtab
set shiftwidth=2

set list "display unprintable characters
set backspace=indent,eol,start
set listchars=tab:»·,nbsp:·,trail:·,extends:>,precedes:<",space:·

set ruler
set showcmd

set laststatus=2

set hlsearch
set incsearch
set ignorecase
set smartcase


set wildmenu
set wildmode=list:longest,full

set splitbelow
set splitright

autocmd BufWritePre *.rb,*.erb,*.rake,*.slim,*.clj,*.js,*.erl,*.ex,*.exs,*.yml,*.yaml,*.tf :%s/\s\+$//e

autocmd BufNewFile,BufRead *.txt setfiletype text
autocmd BufNewFile,BufRead Gemfile,Guardfile,Vagrantfile,Procfile,Rakefile,Brewfile setfiletype ruby
autocmd BufNewFile,BufRead *.yaml.gotmpl setfiletype yaml
autocmd BufNewFile,BufRead Dockerfile* setfiletype dockerfile
autocmd FileType text,markdown,html,xhtml,eruby,asc,slim,js,yaml,yml setlocal wrap linebreak

set ttimeoutlen=100 " decrease timeout for faster insert with 'O' "
set scrolloff=2
set shell=/bin/sh
" "" set wildignore+=*/tmp/*,*/coverage/*,*/log/*,*/bin/*,tags,*/spec/reports/*,*/.git/*,*/app/assets/images/*,*/public/system/*,*/public/assets/*,bin/*
"set wildignore+=*/tmp/*,*/coverage/*,*/log/*,*/bin/*,tags,*/spec/reports/*,*/.git/*,*/app/assets/images/*,*/public/system/*,*/public/assets/*,bin/*,*/web/node_modules/*,*/mobile/node_modules/*

xnoremap <Tab> >gv
xnoremap <S-Tab> <gv

call camelcasemotion#CreateMotionMappings('<leader>')

set mouse=""
let g:netrw_liststyle=3

set re=1

let g:markdown_fenced_languages = ['html', 'javascript', 'ruby', 'bash=sh', 'sql']

map <Leader>b :buffers<CR>:buffer<Space>

set colorcolumn=80,107
set cursorline
noremap <Leader>cl :set cursorline!<CR>
noremap <Leader>cc :set cursorcolumn!<CR>

set clipboard=unnamed

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

nnoremap <silent> <F2> <ESC>:A<CR>
nnoremap <silent> <F3> :noh<CR>
inoremap <silent> <F3> <ESC>:noh<CR>a
nnoremap <silent> <F4> <ESC>:e#<CR>
nnoremap <silent> <F7> :w\|:call RunNearestSpec()<CR>
nnoremap <silent> <F8> :w\|:call RunCurrentSpecFile()<CR>
map <F9> <Plug>(easymotion-bd-f)
map <F10> <Plug>(easymotion-bd-w)

cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack

if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
  let g:ctrlp_user_command='rg %s --files --color=never'
  let g:ctrlp_use_caching = 0
  let g:ackprg = 'rg --vimgrep'
endif

set undodir=~/.vim/undo/
set undofile

" Allow project specific .vimrc's
set exrc
set secure

let g:snipMate = { 'snippet_version' : 1 }
set termguicolors
set background=dark
colorscheme solarized8
