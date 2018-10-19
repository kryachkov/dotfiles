set nocompatible
filetype off

call plug#begin()

Plug 'kien/ctrlp.vim'

Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rvm'
Plug 'vim-ruby/vim-ruby'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-db'

Plug 'tpope/vim-markdown'
Plug 'leshill/vim-json'

Plug 'slim-template/vim-slim'
Plug 'thoughtbot/vim-rspec'

" Snippets support
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'

Plug 'bkad/CamelCaseMotion'

Plug 'Townk/vim-autoclose'

" Coloschemes
Plug 'chriskempson/base16-vim'

Plug 'mileszs/ack.vim'

Plug 'tmhedberg/matchit'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'elixir-lang/vim-elixir'

Plug 'tpope/vim-rails'
Plug 'jgdavey/tslime.vim'
Plug 'kopischke/vim-fetch'
Plug 'AndrewRadev/splitjoin.vim'

Plug 'hashivim/vim-terraform'
Plug 'easymotion/vim-easymotion'

Plug 'vim-erlang/vim-erlang-runtime'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'airblade/vim-gitgutter'

call plug#end()

filetype plugin indent on     " required!
syntax enable

" http://serverfault.com/questions/130632/problems-with-vim-locale-as-non-root-user-on-solaris
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  set fileencodings=utf-8
endif

set tabstop=2
set expandtab
set shiftwidth=2

set list "display unprintable characters
set backspace=indent,eol,start
set listchars=tab:»·,nbsp:·,trail:·,extends:>,precedes:<

set number
set rnu
set numberwidth=4

set ruler
set showcmd

set laststatus=2

set hlsearch
set incsearch
set ignorecase
set smartcase

"Autocomplete mode
set wildmenu
" bash style
"set wildmode=longest,list
" zsh style
set wildmode=list:longest,full

set splitbelow
set splitright

" Copy indent from current line when starting a new line
"set autoindent

" Automatically removing all trailing whitespace
autocmd BufWritePre *.rb,*.erb,*.rake,*.slim,*.clj,*.js,*.erl,*.ex,*.exs :%s/\s\+$//e

" File types autodetection
autocmd BufNewFile,BufRead *.txt setfiletype text
autocmd BufNewFile,BufRead Gemfile,Guardfile,Vagrantfile,Procfile,Rakefile setfiletype ruby
autocmd FileType text,markdown,html,xhtml,eruby,asc,slim,js setlocal wrap linebreak "nolist

" Statusline
if has("statusline") && !&cp
  set laststatus=2  " always show the status bar

  " Start the status line

  " set statusline=%{hostname()}:
  set statusline=%f\ %m\ %r

  " Add rvm
  " if exists('$rvm_path')
  "   set statusline+=%{rvm#statusline()}
  " endif
  " Add fugitive
  set statusline+=%{fugitive#statusline()}

  " display a warning if &paste is set
  " set statusline+=%#error#
  set statusline+=%{&paste?'[paste]':''}
  set statusline+=%*

  " Finish the statusline
  set statusline+=Line:%l/%L[%p%%]
  set statusline+=Col:%v
  set statusline+=Buf:#%n
  set statusline+=[%b][0x%B]
endif

" let mapleader = "\\"

" Rails shortcuts
command! Eapplication :e config/application.rb
command! Eroutes :e config/routes.rb
command! Eschema :e db/schema.rb
command! Egemfile :e Gemfile

autocmd BufWritePost ~/.vimrc source $MYVIMRC

nnoremap <silent> <F3> :noh<CR>
inoremap <silent> <F3> <ESC>:noh<CR>a
nnoremap <silent> <F2> <ESC>:A<CR>
nnoremap <silent> <F4> <ESC>:e#<CR>
nnoremap <silent> <F7> :w\|:call RunNearestSpec()<CR>
nnoremap <silent> <F8> :w\|:call RunCurrentSpecFile()<CR>
map <F9> <Plug>(easymotion-bd-f)
map <F10> <Plug>(easymotion-bd-w)
map <F14> <Plug>GitGutterPrevHunk
map <F15> <Plug>GitGutterNextHunk
nnoremap <silent> <F12> Orequire 'pry'; binding.pry<ESC>:w<CR>
inoremap <silent> <F12> <ESC>Orequire 'pry'; binding.pry<ESC>:w<CR>


set ttimeoutlen=100 " decrease timeout for faster insert with 'O' "
set scrolloff=2
set shell=/bin/sh
" set wildignore+=*/tmp/*,*/coverage/*,*/log/*,*/bin/*,tags,*/spec/reports/*,*/.git/*,*/app/assets/images/*,*/public/system/*,*/public/assets/*,bin/*
set wildignore+=*/tmp/*,*/coverage/*,*/log/*,*/bin/*,tags,*/spec/reports/*,*/.git/*,*/app/assets/images/*,*/public/system/*,*/public/assets/*,bin/*,*/web/node_modules/*,*/mobile/node_modules/*

set cursorline
noremap <Leader>cl :set cursorline!<CR>
noremap <Leader>cc :set cursorcolumn!<CR>

xnoremap <Tab> >gv
xnoremap <S-Tab> <gv

call camelcasemotion#CreateMotionMappings('<leader>')

nmap <Leader>r <Plug>SetTmuxVars
let g:rspec_command = 'call Send_to_Tmux("rspec --format d --color {spec}\n")'

set mouse=""
let g:netrw_liststyle=3

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

set re=1

let g:markdown_fenced_languages = ['html', 'javascript', 'ruby', 'bash=sh', 'sql']

map <Leader>b :buffers<CR>:buffer<Space>

set colorcolumn=107

set clipboard=unnamed

" Hardcore mode on
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
  let g:ctrlp_user_command='rg %s --files --color=never'
  let g:ctrlp_use_caching = 0
  let g:ackprg = 'rg --vimgrep'
endif

cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack

set undodir=~/.vim/undo/
set undofile
