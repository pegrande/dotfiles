
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

" ================= CTRL-P =====================
Bundle 'kien/ctrlp.vim'
map <leader>f :let g:ctrlp_default_input = 0<cr>:CtrlP<cr>
map <leader><leader>f :let g:ctrlp_default_input = 0<cr>:CtrlPClearCache<cr>:CtrlP<cr>

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
Bundle 'nathanaelkane/vim-command-w'

syntax on " turn on syntax highlighting
filetype plugin indent on

"================== Colors ======================
Bundle 'molokai'
colorscheme molokai
set t_vb=
set t_Co=256

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

" ====== Statusline =============================
function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline ctermfg=1 ctermbg=251
  elseif a:mode == 'r'
    hi statusline ctermfg=5 ctermbg=251
  else
    hi statusline ctermfg=82 ctermbg=232
  end
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline ctermfg=82 ctermbg=232

" default the statusline to green when entering Vim
hi statusline ctermfg=82 ctermbg=232

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

" =============== Kill Buffer ===================
nmap <leader>w :CommandW<cr>
