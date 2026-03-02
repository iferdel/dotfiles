" =============================================================================
" Portable .vimrc - based on Neovim config (for SSH / foreign servers)
" =============================================================================

" --- General Settings --------------------------------------------------------
set nocompatible
filetype plugin indent on
syntax on

set shiftwidth=4              " default indentation (matches init.lua)
set tabstop=4
set expandtab
set smartindent
set autoindent

set clipboard=unnamedplus     " use system clipboard
set scrolloff=8               " keep 8 lines above/below cursor
set sidescrolloff=5           " horizontal scroll margin

set number
set relativenumber
set nowrap


set incsearch                 " incremental search
set hlsearch                  " highlight search results
set ignorecase
set smartcase

set splitbelow
set splitright

set wildmenu                  " enhanced command-line completion
set wildmode=longest:full,full

set laststatus=2              " always show status line
set showcmd
set showmode
set ruler

set hidden                    " allow switching buffers without saving
set backspace=indent,eol,start
set ttimeoutlen=50            " fast escape sequences (helps over SSH)

set updatetime=300            " faster CursorHold events

" disable swapfile/backup for remote editing comfort
set noswapfile
set nobackup
set nowritebackup

" --- Leader Key --------------------------------------------------------------
let mapleader = " "
let maplocalleader = "\\"

" --- Keymaps (from init.lua) -------------------------------------------------

" center screen after half-page jumps
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" quickfix navigation
nnoremap <M-j> :cnext<CR>zz
nnoremap <M-k> :cprev<CR>zz

" tab management
nnoremap <F2> :tabnew<CR>
nnoremap <C-j> :tabprevious<CR>
nnoremap <C-k> :tabnext<CR>

" terminal escape (Vim 8+)
if has('terminal')
  tnoremap <C-Space> <C-\><C-n>
  tnoremap <F3> <C-\><C-n>
endif

" open bottom terminal (Vim 8+)
if has('terminal')
  nnoremap <leader>st :botright terminal ++rows=10<CR>
  nnoremap <leader>sc :terminal ++curwin<CR>
endif

" --- Netrw (file explorer, closest to oil.nvim) ------------------------------
let g:netrw_banner = 0        " hide banner
let g:netrw_liststyle = 3     " tree view
let g:netrw_winsize = 25
nnoremap <leader>e :Explore<CR>

" --- Yank Highlight (approximation of TextYankPost autocmd) ------------------
if exists('##TextYankPost')
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup END
endif

" --- Terminal Autocmd (no line numbers in terminal) --------------------------
if has('terminal')
  augroup TerminalSettings
    autocmd!
    autocmd TerminalOpen * setlocal nonumber norelativenumber
  augroup END
endif

" --- Window Separator --------------------------------------------------------
if has('gui_running') || &t_Co >= 256
  highlight WinSeparator ctermfg=White guifg=#ffffff
endif

" --- Filetype-specific Settings (from after/ftplugin/) -----------------------
augroup FileTypeSettings
  autocmd!
  " Go: 2-space indent, no wrap
  autocmd FileType go setlocal shiftwidth=2 tabstop=2 nowrap number relativenumber

  " Python: 4-space indent, no wrap
  autocmd FileType python setlocal shiftwidth=4 tabstop=4 nowrap number relativenumber

  " Lua: 2-space indent, no wrap
  autocmd FileType lua setlocal shiftwidth=2 nowrap number relativenumber

  " Shell: 2-space indent, no wrap
  autocmd FileType sh setlocal shiftwidth=2 nowrap number relativenumber

  " YAML: 2-space indent, no wrap
  autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 nowrap number relativenumber

  " C: 2-space indent, no wrap
  autocmd FileType c setlocal shiftwidth=2 tabstop=2 nowrap number relativenumber

  " SQL: 2-space indent, no wrap
  autocmd FileType sql setlocal shiftwidth=2 tabstop=2 nowrap number relativenumber

  " JSON: 2-space indent, no wrap
  autocmd FileType json setlocal shiftwidth=2 tabstop=2 nowrap number relativenumber

  " Log: 2-space indent, no wrap
  autocmd FileType log setlocal shiftwidth=2 tabstop=2 nowrap number relativenumber

  " HTML / HTMLDjango / JavaScript: line numbers
  autocmd FileType html,htmldjango,javascript setlocal number relativenumber

  " Markdown: 2-space indent, wrap enabled
  autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 wrap number relativenumber
augroup END

" --- Colorscheme (best-effort for 256-color terminals) -----------------------
if &t_Co >= 256 || has('gui_running')
  set background=dark
  " Use a built-in dark scheme; override if tokyonight is available
  try
    colorscheme habamax
  catch
    " fallback
  endtry
endif

" --- Status Line (basic, no plugin needed) -----------------------------------
set statusline=
set statusline+=%#PmenuSel#
set statusline+=\ %f            " filename
set statusline+=\ %m            " modified flag
set statusline+=%=              " right align
set statusline+=\ %y            " filetype
set statusline+=\ %l:%c         " line:column
set statusline+=\ %p%%          " percentage
set statusline+=\
