
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
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-rails'

" ============== Hardmode ======================
Bundle 'wikitopian/hardmode'

nnoremap <leader>h <esc>:call ToggleHardMode()<cr>
let g:HardMode_hardmodeMsg = "What is this crazy thing?"

" ================= CTRL-P =====================
Bundle 'kien/ctrlp.vim'
map <leader>f :let g:ctrlp_default_input = 0<cr>:CtrlP<cr>
map <leader><leader>f :let g:ctrlp_default_input = 0<cr>:CtrlPClearCache<cr>:CtrlP<cr>

Bundle 'JazzCore/ctrlp-cmatcher'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard']
let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }

" ================== ACK! ======================
Bundle 'mileszs/ack.vim'
map <leader>a :Ack!<space>
map <leader>A :Ack! <C-R><C-W><CR>

Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-rails'

" Kills a buffer without closing a split, use ,w . Used in conjunction
" with command-w, below...
Bundle 'vim-scripts/bufkill.vim'

" Smarts around killing buffers, will close the split if it's the last buffer in
" it, and close vim if it's the last buffer/split. Use ,w
Bundle 'aaronjensen/vim-command-w'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vroom
"
" Run specs or cucumber features with ,t run only the test under the cursor
" with ,T also remembers last run test so you can hit it again on non-test
" files to run the last run test
"
" Using my fork until: https://github.com/skalnik/vim-vroom/pull/33
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'aaronjensen/vim-vroom'

let g:vroom_map_keys = 0
let g:vroom_write_all = 1
let g:vroom_use_bundle_exec = 0
let g:vroom_spec_command = '`([ -e .zeus.sock ] && echo zeus) || echo bundle exec` rspec '
let g:vroom_cucumber_path = '`([ -e .zeus.sock ] && echo zeus) || echo bundle exec` cucumber -r features '
let g:vroom_use_colors = 1
map <leader>t :VroomRunTestFile<cr>
map <leader>T :VroomRunNearestTest<cr>

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
filetype plugin indent on

"================== Colors ======================
Bundle 'ap/vim-css-color'
Bundle 'molokai'
colorscheme molokai
set t_vb=
set t_Co=256

Bundle 'altercation/vim-colors-solarized'

syntax enable
set background=dark
" colorscheme solarized

hi Search ctermbg=Green
hi Search ctermfg=Black

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

" ================== Powerline ==================
set rtp+=~/Library/Python/2.7/lib/python/site-packages/powerline/bindings/vim/
let g:Powerline_symbols = 'fancy'

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
    let &t_SI = "\<Esc>[3 q"
    let &t_EI = "\<Esc>[0 q"
  else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif
end

" ====== Whitespace / Indentation ===============
set nowrap               " don't wrap lines
set tabstop=2            " a tab is two spaces
set shiftwidth=2         " an autoindent (with <<) is two spaces
set softtabstop=2
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
autocmd BufWritePre * :%s/\s\+$//e " remove trailing whitespace on save

" ================ Completion =======================
set wildmode=longest,list
set wildmenu
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.class,.svn,*.gem,public/javascripts/compiled " disable output and VCS files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz       " disable archive files
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*,bundle,jhw-cache  " ignore bundler and sass cache
set wildignore+=*/public/system/*,public/javascripts/compiled  " ignore assets
set wildignore+=*.swp,tmp,*~,._*       " ignore temp and backup files
set wildignore+=*.orig,*.jpg,*.png,*.gif
set wildignore+=log,solr
set wildignore+=bundler_stubs,build,error_pages

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
map <leader>s :split<cr>
map <leader>v :vsplit<cr>

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" =============== Save with W ===================
command! W write

" =============== Kill Buffer ===================
nmap <leader>w :CommandW<cr>

" =============== Alternate leader key ===================
nmap , <space>

" =============== Copy paste system clipboard ===================
map <leader>y "*y
map <leader>p "*p
map <leader>P "*P
