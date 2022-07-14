set nocompatible              " be iMproved, required
call plug#begin('~/.local/share/nvim/plugged')
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'ycm-core/YouCompleteMe'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-commentary'
Plug 'joshdick/onedark.vim'
Plug 'mileszs/ack.vim'
Plug 'vim-vdebug/vdebug'
"Plug 'dikiaap/minimalist'
call plug#end()
filetype off                  " required

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
let g:ag_working_path_mode="r"
let g:ycm_use_clangd = 1
let g:ycm_max_diagnostics_to_display = 0
let vim_markdown_preview_github = 1
let vim_markdown_preview_use_xdg_open= 1
set autoindent
set encoding=utf-8
set tabstop=4 expandtab softtabstop=0 shiftwidth=4
set number
set showmatch
set foldmethod=syntax
set wildmode=longest,full
set wildmenu
set splitright

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
"
"onedark.vim override: Set a custom background color in the terminal
if (has("autocmd") && !has("gui_running"))
  augroup colors
    autocmd!
    let s:background = { "gui": "#000000", "cterm": "235", "cterm16": "0" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "bg": s:background }) "No `fg` setting
  augroup END
endif

syntax on
colorscheme onedark

"PHP
let g:php_folding = 2
"
"Ultisnips configuration
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"Ctags generation
"au BufWritePost *.php silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &
let g:gutentags_exclude = ['*.css', '*.html', '*.js', '*.json', '*.xml', 
            \ '*.phar', '*.ini', '*.rst', '*.md',
            \ '*.cmd',
            \ '*build/*', '*travis/*', '*dist/*',
            \ '*var/cache*', '*var/log*']

let g:gutentags_ctags_extra_args = ['--fields=+aimlS --PHP-kinds=+cdfint-av']

"NERDTree
" Start NERDTree. If a file is specified, move the cursor to its window.
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif"

"Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
            \ quit | endif
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
            \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Open the existing NERDTree on each new tab.
autocmd BufEnter * silent NERDTreeMirror

"Vdebug
let g:vdebug_options= {
\    "port" : 10000,
\    "server" : '',
\    "timeout" : 20,
\    "on_close" : 'detach',
\    "break_on_open" : 0,
\    "ide_key" : 'netbeans-xdebug',
\    "watch_window_style" : 'compact',
\    "marker_default"     : '⬦',
\    "marker_closed_tree" : '▸',
\    "marker_open_tree" : '▾',
\    "path_maps" : {
\       "/var/www/html": '/home/julio/projects/php/hdiv-php-agent/integration-tests/target/466b81c5-393a-37c7-8cb8-960ec2795f8f/php_5_3_fpm/apps/html/',
\       "/usr/local/lib/php/HTML/Template/" : '/home/julio/projects/php/hdiv-php-agent/integration-tests/HTML_Template_Sigma/HTML/Template',
\       "/opt/hdiv/php/agent/src" : '/home/julio/projects/php/hdiv-php-agent/src/'
\    }
\}
