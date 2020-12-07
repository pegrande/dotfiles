
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" TODO: this may not be in the correct place. It is intended to allow overriding <Leader>.
" source ~/.vimrc.before if it exists.
if filereadable(expand("~/.vimrc.before"))
  source ~/.vimrc.before
endif

let mapleader = " " " set leader

" ================== Vundle =====================
filetype on
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

Bundle 'gmarik/vundle'

" ============== Hardmode ======================
Bundle 'wikitopian/hardmode'

nnoremap <leader>h <esc>:call ToggleHardMode()<cr>
let g:HardMode_hardmodeMsg = "What is this crazy thing?"

" ================= CTRL-P =====================
Bundle 'kien/ctrlp.vim'
" Uncomment to map ctrlp
map <leader>f :let g:ctrlp_default_input = 0<cr>:CtrlP<cr>
map <leader><leader>f :let g:ctrlp_default_input = 0<cr>:CtrlPClearCache<cr>:CtrlP<cr>

" Plugin 'JazzCore/ctrlp-cmatcher'
" let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
"
Bundle 'FelikZ/ctrlp-py-matcher'
let g:ctrlp_match_func = {'match' : 'pymatcher#PyMatch' }


if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'cd %s && ag --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$"'

  " ag is fast enough that CtrlP doesn't need to cache
  " no it isn't
  " let g:ctrlp_use_caching = 0
else
  " Fall back to using git ls-files if Ag is not available
  let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif

" Don't manage working directory
let g:ctrlp_working_path_mode = 0
let g:ctrlp_follow_symlinks = 2

" Only search open buffers
map <leader>u :let g:ctrlp_default_input = 0<cr>:CtrlPBuffer<cr>
map <leader>U :let g:ctrlp_default_input = 0<cr>:CtrlPLine<cr>

" ================== ACK!/AG! ======================
Bundle 'mileszs/ack.vim'
Bundle 'rking/ag.vim'

map <leader>a :Ag!<space>
map <leader>A :Ag! <C-R><C-W><CR>

" Use ag for search, it's much faster than ack.
" See https://github.com/ggreer/the_silver_searcher
" on mac: brew install the_silver_searcher
let g:ag_prg = 'ag --nogroup --nocolor --column --smart-case'

Bundle 'kchmck/vim-coffee-script'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-eunuch'
Bundle 'nono/vim-handlebars'
Bundle 'slim-template/vim-slim'
Bundle 'itspriddle/vim-jquery'
Bundle 'fatih/vim-go'
Bundle 'maxmellon/vim-jsx-pretty'
Bundle 'mlaursen/vim-react-snippets'

" Kills a buffer without closing a split, use ,w . Used in conjunction
" with command-w, below...
Bundle 'vim-scripts/bufkill.vim'

" Smarts around killing buffers, will close the split if it's the last buffer in
" it, and close vim if it's the last buffer/split. Use ,w
Bundle 'aaronjensen/vim-command-w'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" dash.vim
"
" Look up words in dash
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'rizzatti/dash.vim'
nmap <silent> <leader>g <Plug>DashGlobalSearch
nmap <silent> <leader><leader>g <Plug>DashSearch

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vimux
"
" Setup vimux so vroom dispatches in the side Terminal panel
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'benmills/vimux'

let g:VimuxOrientation = 'h'
let g:VimuxPromptString = "Cmd: "
let g:VimuxHeight = "30"
map <leader>q :VimuxPromptCommand 'exit'<cr><cr>
map <leader>c :VimuxPromptCommand<cr>
map <leader>C :RunLastVimTmuxCommand<cr>

map <leader>z :!clear; python %:p<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vroom
"
" Run specs or cucumber features with ,t run only the test under the cursor
" with ,T also remembers last run test so you can hit it again on non-test
" files to run the last run test
"
" Using my fork until: https://github.com/skalnik/vim-vroom/pull/33
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'skalnik/vim-vroom'

" let g:vroom_map_keys = 0
" let g:vroom_write_all = 1
" let g:vroom_use_bundle_exec = 0
" let g:vroom_use_colors = 1
" let g:vroom_clear_screen = 0
" let g:vroom_use_vimux = 1
" map <leader>t :VroomRunTestFile<cr>
" map <leader>T :VroomRunNearestTest<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim-Test
"
" https://github.com/janko-m/vim-test
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'janko-m/vim-test'

let test#strategy = "vimux"
let test#python#runnr = "unittest"

map <leader>t :TestFile<cr>
map <leader>T :TestNearest<cr>
"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim-Nose-Test
"
" https://github.com/pitluga/vimux-nose-test
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bundle 'pitluga/vimux-nose-test'

" let g:NoseVirtualenv = "~/.virtualenvs/ocr/bin/activate"
" map <leader>t :RunNoseTestBuffer<cr>
" map <leader>T :RunNoseTestFocused<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tab to indent or autocomplete depending on context
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'ervandew/supertab'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fugitive
"
" Git in vim, use ,gs for git status then - to stage then C to commit
" check :help Gstatus for more keys
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'tpope/vim-fugitive'

map <leader>gs :Gstatus<cr>
map <leader>gc :Gcommit<cr>
map <leader>ga :Git add --all<cr>:Gcommit<cr>
map <leader>gb :Gblame<cr>

" Use j/k in status
function! BufReadIndex()
  setlocal cursorline
  setlocal nohlsearch

  nnoremap <buffer> <silent> j :call search('^#\t.*','W')<Bar>.<CR>
  nnoremap <buffer> <silent> k :call search('^#\t.*','Wbe')<Bar>.<CR>
endfunction
autocmd BufReadCmd  *.git/index exe BufReadIndex()
autocmd BufEnter    *.git/index silent normal gg0j

" Start in insert mode for commit
function! BufEnterCommit()
  normal gg0
  if getline('.') == ''
    start
  end
endfunction
autocmd BufEnter    *.git/COMMIT_EDITMSG  exe BufEnterCommit()

" Automatically remove fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

syntax on " turn on syntax highlighting

"================== Colors ======================
Bundle 'ap/vim-css-color'
Bundle 'tomasr/molokai'
colorscheme molokai
set t_vb=
set t_Co=256

Bundle 'altercation/vim-colors-solarized'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Powerline
"
" The ultimate vim statusline utility
"
" You'll need a powerline patched font.
" You should probably use inconsolata-g (included in fonts directory)
"
" If not, you can patch your own.
" See: https://github.com/Lokaltog/vim-powerline/tree/develop/fontpatcher
" You'll probably need this too:
" https://github.com/jenius/Fontforge-Installer
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bundle 'Lokaltog/vim-powerline'

" let g:Powerline_symbols = 'fancy'
" let g:Powerline_stl_path_style = 'relative'
" call Pl#Theme#RemoveSegment('fugitive:branch')
" call Pl#Theme#RemoveSegment('fileformat')
" call Pl#Theme#RemoveSegment('fileencoding')
" call Pl#Theme#RemoveSegment('scrollpercent')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline
"
" Replacing powerline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'bling/vim-airline'

let g:airline_powerline_fonts = 1

if !exists('g:airlinesymbols')
let g:airlinesymbols = {}
endif
"     " airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V',
    \ '^V' : 'V',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '^S' : 'S',
    \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Nerdtree
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'scrooloose/nerdtree'

Bundle 'vim-python/python-syntax'
let g:python_highlight_all = 1

filetype plugin indent on

syntax enable
set background=dark
" colorscheme solarized

hi Search ctermbg=5

" ============== :E View =======================
map <leader>k :E<cr>

" ============== Backups and swap ===============
set nobackup
set nowritebackup
set noswapfile
set backupdir=~/.vim/backup
set directory=~/.vim/temp

" ============== General Config =================
" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden
set history=10000                 " store lots of command line history
set number                        " line numbers on
set ruler                         " show line and column numbers
set switchbuf=useopen
set encoding=utf-8                " set default encoding to UTF-8
set visualbell                    " don't beep
set noerrorbells
set backspace=indent,eol,start    " allow backspace in insert mode
set laststatus=2                  " always show the status bar
set ttimeoutlen=5

" Highlight a column
" set cc=90
" hi ColorColumn ctermbg=236
" hi ColorColumn ctermfg=58

" function! HighlightSearch(
"  if &hls
"    return 'H'
"  else
"    return ''
"  endif
"endfunction

" ======= Window Heights ========================
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will fail.
set winheight=5
set winminheight=5
set winheight=999

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Preview window size hack
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ResizePreviewWindow()
  if &previewwindow
    set winheight=999
  endif
endfunction
autocmd WinEnter * call ResizePreviewWindow()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This enables iterm cursor changes from vim. In .tmux.conf you'll need:
" set-option -g terminal-overrides '*88col*:colors=88,*256col*:colors=256,xterm*:XT:Ms=\E]52;%p1%s;%p2%s\007:Cc=\E]12;%p1%s\007:Cr=\E]112\007:Cs=\E]50;CursorShape=%?%p1%{3}%<%t%{0}%e%p1%{2}%-%;%d\007'
"
" Source - https://github.com/Casecommons/casecommons_workstation/blob/master/templates/default/dot_tmux.conf.erb
"          https://github.com/Casecommons/vim-config/blob/master/init/tmux.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists('$ITERM_PROFILE')
  if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif
end

" ====== Whitespace / Indentation ===============
au BufNewfile,BufRead, *.py
      \ set tabstop=4            " a tab is two spaces
      \ set shiftwidth=4         " an autoindent (with <<) is two spaces
      \ set softtabstop=4

set tabstop=2            " a tab is two spaces
set shiftwidth=2         " an autoindent (with <<) is two spaces
set softtabstop=2
set textwidth=79
set nowrap               " don't wrap lines
set expandtab            " use spaces, not tabs
set autoindent
set smartindent
set smarttab
set linebreak             " wrap at convenient points

set list                  " show invisible characters
set listchars=""          " reset listchars
set listchars=tab:\ \     " a tab should display as "  "
set listchars+=trail:·    " show trailing spaces as dots
set listchars+=extends:>  " line continuation character
set listchars+=precedes:< " line continuation character

" =============== Folding =======================
set foldmethod=indent     " fold based on indent
set foldnestmax=3         " deepest fold level
set nofoldenable          " don't fold by default

" =============== Search ========================
set incsearch             " find the next match as we type
set hlsearch              " highlight matches
set ignorecase            " case insensitive search
set smartcase             " unless they contain at lease one capital letter

" ============== Scrolling ======================
set scrolloff=8           "Start scrolling when scrolloff lines away from margins

" ============== Auto Commands ==================
autocmd BufNewFile,BufRead *.json set ft=javascript " treat JSON files like JavaScript
autocmd BufNewFile,BufRead *.hamlc set ft=haml
autocmd VimResized * wincmd = " resize splits when window size changes
autocmd FileType xml exe ":silent %!xmllint --format --recover - 2>/dev/null"
augroup Miscellaneous
  au!
  " Remember last location in file
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif

  " Remove trailing whitespace
  au FileType coffee,eruby,haml,javascript,php,ruby,sass,scss,sh,xml
    \ au BufWritePre <buffer>
      \ let pos = getpos('.')
      \ | execute '%s/\s\+$//e'
      \ | call setpos('.', pos)
augroup END

au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

"
" ================ Completion =======================
"
" Python Completion
" Bundle 'Valloric/YouCompleteMe'
" let g:ycm_autoclose_preview_window_after_completion=1
" map <leader><leader>d  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"One issue with the goto definition above is that VIM by default doesn’t know 
"anything about virtualenv, so you have to make VIM and YouCompleteMe aware of 
"your virtualenv by adding the following lines of code to .vimrc:

"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" PEP8 
Bundle 'nvie/vim-flake8'

autocmd FileType python map <buffer> <leader>e :call Flake8()<cr>

if exists("g:ctrlp_user_command")
  unlet g:ctrlp_user_command
endif

set wildmode=longest,list
set wildmenu
set wildignore+=*.o,*.out,*.obj,*.pyc,.git,*.rbc,*.class,.svn,*.gem,public/javascripts/compiled " disable output and VCS files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz       " disable archive files
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/vendor/assets/*,*/.bundle/*,*/.sass-cache/*,bundle,jhw-cache  " ignore bundler and sass cache
set wildignore+=*/public/system/*,public/javascripts/compiled,*/public/media/*  " ignore assets
set wildignore+=*.swp,tmp,*~,._*       " ignore temp and backup files
set wildignore+=*.orig,*.jpg,*.png,*.gif
set wildignore+=log,solr
set wildignore+=bundler_stubs,build,error_pages
set wildignore+=*/node_modules/*

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.

silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile

" ============= Disable Arrow Keys ==============
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" =============== Easy Splitting ================
" Uncomment to map splitting
" map <leader>s :split<cr>
" map <leader>v :vsplit<cr>

" Uncomment to map window switching
" map <C-h> <C-w>h
" map <C-j> <C-w>j
" map <C-k> <C-w>k
" map <C-l> <C-w>l

" =============== Normal Mode Insert Space =========
nmap <S-Enter> O<Esc>

" =============== Kill Buffer ===================
nmap <leader>w :CommandW<cr>

" =============== Alternate leader key ===================
nmap , <space>

" =============== Copy paste system clipboard ===================
map <leader>y "*y
map <leader>p "*p
map <leader>P "*P
