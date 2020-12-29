set nocompatible               " Be iMproved
" --------- plugins
" :PlugUpdate to install/update
" :PlugUpgrade to upgrade plug
" :PlugClean to remove old stuff
"
if has('win32') || has ('win64')
    let $VIMHOME = $HOME."/vimfiles"
else
    let $VIMHOME = $HOME."/.vim"
endif

" download vim-plug if missing 
if empty(glob($VIMHOME . '/autoload/plug.vim'))
    if has('win32')
        echoerr 'Please download https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim to '. expand($VIMHOME . '/autoload/plug.vim')
    else
        call system("curl -fkLo " . expand($VIMHOME . '/autoload/plug.vim') . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim")
        autocmd VimEnter * PlugInstall
    endif
endif
call plug#begin($VIMHOME . '/plugged')


" packages

Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/syntastic' " syntax fixes
Plug 'tpope/vim-endwise' " automatically end scopes etc
Plug 'ryanoasis/vim-devicons'

" search stuff
Plug 'junegunn/fzf.vim' " searches
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-projectionist' " Switch between .c and .h files using :AT

" Git stuff
Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/gitignore'
Plug 'airblade/vim-gitgutter'

" Syntax Highlighting
Plug 'sheerun/vim-polyglot'
Plug 'gburca/vim-logcat'

" LaTeX stuff
Plug 'lervag/vimtex'

" Python stuff
Plug 'vim-scripts/indentpython.vim'
Plug 'nvie/vim-flake8'

" Camel cased motion
Plug 'bkad/CamelCaseMotion'

Plug 'justinmk/vim-sneak'

Plug 'stephpy/vim-yaml'


" Add plugins to &runtimepath
call plug#end()
" --------- plugins

set laststatus=2
let g:airline_theme             = 'solarized'
let g:airline_powerline_fonts = 1
if has("win32")
	set guifont=DejaVu_Sans_Mono_for_PowerLine
else
	set guifont=MesloLGS\ Nerd\ Font
endif

if !has("win32")
" ctrl-p speed
if executable('rg')
    set grepprg=rg\ --vimgrep
    let g:ctrlp_user_command = 'rg --files %s'
    let g:ctrlp_use_caching = 0
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif

call camelcasemotion#CreateMotionMappings('<leader>')

" load fzf
set rtp+=/usr/local/opt/fzf
endif

" Turn on filetype plugins (:help filetype-plugin).
if has('autocmd')
  filetype plugin indent on
endif

" Enable syntax highlighting.
if has('syntax')
  syntax enable
endif

" Autoindent when starting new line, or using `o` or `O`.
set autoindent

" Allow backspace in insert mode.
set backspace=indent,eol,start

" Don't scan included files. The .tags file is more performant.
set complete-=i

" Use 'shiftwidth' when using `<Tab>` in front of a line.
" By default it's used only for shift commands (`<`, `>`).
set smarttab

" Disable octal format for number processing.
set nrformats-=octal

" Allow for mappings including `Esc`, while preserving
" zero timeout after pressing it manually.
set ttimeout
set ttimeoutlen=100

" Enable highlighted case-insensitive incremential search.
set incsearch

" Indent using four spaces.
set tabstop=4
set shiftwidth=4
set expandtab

" Use `Ctrl-L` to clear the highlighting of :set hlsearch.
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

" Always show window statuses, even if there's only one.
set laststatus=2

" Show the line and column number of the cursor position.
set ruler

" Show the size of block one selected in visual mode.
set showcmd

" Autocomplete commands using nice menu in place of window status.
" Enable `Ctrl-N` and `Ctrl-P` to scroll through matches.
set wildmenu

" When 'wrap' is on, display last line even if it doesn't fit.
set display+=lastline

" Force utf-8 encoding in GVim
if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

" Set default whitespace characters when using `:set list`
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+

" Delete comment character when joining commented lines
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j
endif

" Search upwards for tags file instead only locally
if has('path_extra')
  setglobal tags-=./tags tags^=./tags;
endif

" Reload unchanged files automatically.
set autoread

" Support all kind of EOLs by default.
set fileformats+=mac

" Increase history size to 1000 items.
set history=1000

" Allow for up to 50 opened tabs on Vim start.
set tabpagemax=50

" Always save upper case variables to viminfo file.
set viminfo^=!

" Enable backup and undo files by default.
let s:dir = has('win32') ? '$APPDATA/Vim' : isdirectory($HOME.'/Library') ? '~/Library/Vim' : empty($XDG_DATA_HOME) ? '~/.local/share/vim' : '$XDG_DATA_HOME/vim'
let &backupdir = expand(s:dir) . '/backup//'
let &undodir = expand(s:dir) . '/undo//'
set undofile

" Automatically create directories for backup and undo files.
if !isdirectory(expand(s:dir))
    if has("win32") || has("win16")
        call system("mkdir " . expand(s:dir) . "\\backup")
        call system("mkdir " . expand(s:dir) . "\\undo")
    else
        call system("mkdir -p " . expand(s:dir) . "/{backup,undo}")
    end
end

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif



" `Ctrl-U` in insert mode deletes a lot. Use `Ctrl-G` u to first break undo,
" so that you can undo `Ctrl-U` without undoing what you typed before it.
inoremap <C-U> <C-G>u<C-U>

"" Extras

" Y yanks from the cursor to the end of line as expected. See :help Y.
nnoremap Y y$

" Keep 8 lines above or below the cursor when scrolling.
set scrolloff=8

" Keep 15 columns next to the cursor when scrolling horizontally.
set sidescroll=1
set sidescrolloff=15

" Set minimum window size to 79x5.
set winwidth=79
set winheight=5
set winminheight=5

" If opening buffer, search first in opened windows.
set switchbuf=usetab

" Hide buffers instead of asking if to save them.
set hidden

" Wrap lines by default
set wrap linebreak
" wrapped lines follow indent of the line it wraps
set breakindent 
set showbreak=\ \ 

" Allow easy navigation between wrapped lines.
vmap j gj
vmap k gk
nmap j gj
nmap k gk

" For autocompletion, complete as much as you can.
set wildmode=longest,full

" Show line numbers on the sidebar.
set number

" Disable any annoying beeps on errors.
set noerrorbells
set visualbell

" Don't parse modelines (google "vim modeline vulnerability").
set nomodeline

" Do not fold by default. But if, do it up to 3 levels.
set foldmethod=indent
set foldnestmax=3
set nofoldenable

" Enable mouse for scrolling and window resizing.
set mouse=a

" Disable swap to prevent annoying messages.
set noswapfile

" Save up to 100 marks, enable capital marks.
set viminfo='100,f1

" Enable search highlighting.
set hlsearch

" Ignore case when searching.
set ignorecase
" Don't ignore case when search has capital letter
" (although also don't ignore case by default).
set smartcase

" Show mode in statusbar, not separately.
set noshowmode


" Use dash as word separator.
set iskeyword+=-

" Add gems.tags to files searched for tags.
set tags+=gems.tags

" Disable output, vcs, archive, rails, temp and backup files.
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
set wildignore+=*.swp,*~,._*


" Auto center on matched string.
noremap n nzz
noremap N Nzz

" Visually select the text that was last edited/pasted (Vimcast#26).
noremap gV `[v`]

" Expand %% to path of current buffer in command mode.
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Enable saving by `Ctrl-s`
nnoremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>

" Set window title by default.
set title

" Always focus on splited window.
nnoremap <C-w>s <C-w>s<C-w>w
nnoremap <C-w>v <C-w>v<C-w>w

" Don't display the intro message on starting Vim.
set shortmess+=I

" Accept CtrlP selections also with <Space>
let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("e")': ['<Space>', '<CR>', '<2-LeftMouse>'],
  \ }

" Make sure pasting in visual mode doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

" Prevent common mistake of pressing q: instead :q
map q: :q

" Make a simple "search" text object.
" http://vim.wikia.com/wiki/Copy_or_change_search_hit
" It allows for replacing search matches with cs and then /././.
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>



set nocscopeverbose

if has('gui_running')
  " Copy and pasting easier
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>
endif

colorscheme solarized
set background=dark
set spell
set spelllang=en_us


autocmd BufNewFile,BufReadPost *.ino setlocal filetype=arduino
autocmd BufNewFile,BufReadPost *.pde setlocal filetype=arduino
autocmd FileType gitcommit setlocal textwidth=0 spell
autocmd FileType jade setlocal textwidth=0 spell
autocmd FileType stylus setlocal textwidth=0
autocmd FileType latex setlocal textwidth=0 spell
autocmd FileType make setlocal noexpandtab
autocmd FileType yaml,yml setlocal ts=2 sts=2 sw=2 expandtab

au BufRead,BufNewFile *.jar,*.war,*.ear,*.sar,*.rar set filetype=zip
autocmd BufRead,BufNewFile *.apk set filetype=zip
autocmd BufRead,BufNewFile SConstruct set filetype=python

" PEP8
au BufNewFile,BufRead *.py
            \ set tabstop=4
            \ set softtabstop=4
            \ set shiftwidth=4
            \ set textwidth=79
            \ set expandtab
            \ set autoindent
            \ set fileformat=unix

" nicer python highlighting
let python_highlight_all=1

"always make tex file latex files
let g:tex_flavor = "latex"


if !has("win32")
    " ----- scrooloose/syntastic settings -----
    let g:syntastic_check_on_open = 1
    let g:syntastic_error_symbol = '✘'
    let g:syntastic_warning_symbol = "▲"
    augroup mySyntastic
      au!
      au FileType tex let b:syntastic_mode = "passive"
    augroup END
    let g:airline#extensions#syntastic#enabled = 1
endif


" ----- airblade/vim-gitgutter settings -----
" Required after having changed the colorscheme
hi clear SignColumn
" In vim-airline, only display "hunks" if the diff is non-zero
let g:airline#extensions#hunks#non_zero_only = 1


" vimtex settings
let g:vimtex_latexmk_continuous = 1
"let g:vimtex_quickfix_ignore_all_warnings = 1
let g:vimtex_quickfix_ignored_warnings = [
            \ 'Underfull',
            \ 'Overfull',
            \ 'specifier changed to',
            \ ]
" only open quick fix window for errors
let g:vimtex_quickfix_open_on_warning = 0
" skim settings
if has("unix")
    let s:uname = system("uname -s")
    if s:uname == "Darwin"
        let g:vimtex_view_general_viewer
              \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
        let g:vimtex_view_general_options = '-r @line @pdf @tex'
    endif
elseif has('win32') || has ('win64')
    let g:vimtex_view_general_viewer = 'SumatraPDF' 
    let g:vimtex_view_general_options='-reuse-instance -forward-search @tex @line @pdf'
    let g:vimtex_view_general_options_latexmk='-reuse-instance'
endif


if has("unix")
    let s:uname = system("uname -s")
    if s:uname == "Darwin"
        " This adds a callback hook that updates Skim after compilation
        let g:vimtex_latexmk_callback_hooks = ['UpdateSkim']
        function! UpdateSkim(status)
          if !a:status | return | endif

          let l:out = b:vimtex.out()
          let l:tex = expand('%:p')
          let l:cmd = [g:vimtex_view_general_viewer, '-r']
          if !empty(system('pgrep Skim'))
            call extend(l:cmd, ['-g'])
          endif
          if has('nvim')
            call jobstart(l:cmd + [line('.'), l:out, l:tex])
          elseif has('job')
            call job_start(l:cmd + [line('.'), l:out, l:tex])
          else
            call system(join(l:cmd + [line('.'), shellescape(l:out), shellescape(l:tex)], ' '))
          endif
        endfunction
    endif
endif
