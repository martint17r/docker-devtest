scriptencoding utf-8 set nocompatible

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'mileszs/ack.vim'
Plugin 'Shougo/neocomplete.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ctrlp.vim'
Plugin 'Tagbar'
Plugin 'fatih/molokai'
Plugin 't9md/vim-choosewin'
"Plugin 'tpope/vim-fugitive'
"Plugin 'pangloss/vim-javascript'
"Plugin 'mxw/vim-jsx'
"Plugin 'MaxMEllon/vim-jsx-pretty'
Plugin 'editorconfig/editorconfig-vim'
"Plugin 'neomake/neomake'
"Plugin 'wincent/terminus'
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'
"Plugin 'fxn/vim-monochrome'
Plugin 'martint17r/nofrils'
Plugin 'fatih/vim-go'
call vundle#end()

filetype plugin indent on

"set clipboard=unnamed
let mapleader = "ä"
let g:ackprg = 'ag --nogroup --nocolor --column'
nnoremap <Leader>a :Ack<Space>""<Left>

set number
set relativenumber
set lazyredraw

set nobackup
set hidden "switch modified buffers

set completeopt-=preview
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  "return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType go setlocal omnifunc=go#complete#Complete

imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

let g:go_fmt_command = "goimports"
let g:go_textobj_enabled = 1
let g:go_auto_type_info = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_extra_types = 0
let g:go_list_type = "quickfix"
let g:go_def_mapping_enabled = 0
let g:go_info_mode = "guru"
let g:go_snippet_engine = "neosnippet"

nmap öö ]]
nmap ÖÖ [[

map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <C-q> :cclose<CR>
nnoremap s <C-w>

au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
au Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
au FileType go nmap <leader>c <Plug>(go-coverage-toggle)
au FileType go nmap <leader>g <Plug>(go-def-vertical)
au FileType go nmap <leader>r <Plug>(go-rename)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>, <Plug>(go-describe)
au FileType go nmap <leader>i <Plug>(go-implements)
au FileType go nmap <leader>l <Plug>(go-metalinter)
au FileType go nnoremap <C-S-O> :GoDefPop<CR>
au FileType go nnoremap <leader>j :GoDeclsDir<CR>
au FileType go nnoremap <buffer> <silent> gd :GoDef<cr>
au FileType go nnoremap <leader><space> :noh<cr>:GoSameIdsClear<cr>

nmap <F10> :TagbarToggle<CR>
let g:tagbar_autoschowtag = 1
let g:tagbar_show_visibility = 0
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }


syntax on
set tabstop=4 shiftwidth=4 expandtab

set showmode
set ttyfast
set ruler
set visualbell

set t_Co=256
let g:nofrils_heavycomments=1
let g:nofrils_heavylinenumbers=1
let g:molokai_original = 1
colorscheme nofrils-dark

set guifont=Meslo\ LG\ M\ DZ\ Regular\ 12
let g:airline_theme='molokai'
let g:airline_mode_map = {'n': 'N', 'i' : 'I', 'R': 'R', 'v': 'V', 'V': 'V'}
let g:airline_section_z = airline#section#create(['windowswap', 'obsession', 'linenr', 'maxlinenr', g:airline_symbols.space.':%3v'])
let g:airline#extensions#branch#enabled=1
set laststatus=2

set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap q :b#<cr>
nnoremap <space><space> :update<cr>
au FileType go nnoremap <space><space> :update<cr>:noh<cr>:GoSameIdsClear<cr>

let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_custom_ignore = 'vendor\|node_modules\|\.DS_Store\|\.git'
let g:ctrlp_dotfiles = 1
let g:ctrlp_open_new_file = 'r'

nmap - /
nmap <leader>- <Plug>(choosewin)
let g:choosewin_overlay_enable = 0

inoremap jj <ESC>

au BufEnter /tmp/crontab.* setl backupcopy=yes

let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
"autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
"autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

"autocmd! BufWritePost * Neomake
"let g:neomake_go_gometalinter_args = ['--disable-all', '--enable=gosimple', '--enable=unused', '--enable=misspell', '--enable=staticcheck', '--enable=interfacer', '--enable=errcheck', '--enable=vetshadow']
"let g:neomake_javascript_jshint_maker = {
"    \ 'args': ['--verbose'],
"    \ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)',
"    \ }
"let g:neomake_serialize = 1
"let g:neomake_serialize_abort_on_error = 1

autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

if exists('$SUDO_USER')
  set nobackup                        " don't create root-owned files
  set nowritebackup                   " don't create root-owned files
else
  set backupdir=~/local/.vim/tmp/backup
  set backupdir+=~/.vim/tmp/backup    " keep backup files out of the way
  set backupdir+=.
endif

if exists('$SUDO_USER')
  set noswapfile                      " don't create root-owned files
else
  set directory=~/local/.vim/tmp/swap//
  set directory+=~/.vim/tmp/swap//    " keep swap files out of the way
  set directory+=.
endif
set swapsync=                         " let OS sync swapfiles lazily
set updatecount=80                    " update swapfiles every 80 typed chars
set updatetime=2000                   " same as YCM

if has('linebreak')
  set breakindent                     " indent wrapped lines to match start
  if exists('&breakindentopt')
    set breakindentopt=shift:2        " emphasize broken lines by indenting them
  endif
endif

if has('persistent_undo')
  if exists('$SUDO_USER')
    set noundofile                    " don't create root-owned files
  else
    set undodir=~/local/.vim/tmp/undo
    set undodir+=~/.vim/tmp/undo      " keep undo files out of the way
    set undodir+=.
    set undofile                      " actually use undo files
  endif
endif

if has('linebreak')
  set linebreak                       " wrap long lines at characters in 'breakat'
endif

if has('viminfo')
  if exists('$SUDO_USER')
    set viminfo=                      " don't create root-owned files
  else
    if isdirectory('~/local/.vim/tmp')
      set viminfo+=n~/local/.vim/tmp/viminfo
    else
      set viminfo+=n~/.vim/tmp/viminfo " override ~/.viminfo default
    endif

    if !empty(glob('~/.vim/tmp/viminfo'))
      if !filereadable(expand('~/.vim/tmp/viminfo'))
        echoerr 'warning: ~/.vim/tmp/viminfo exists but is not readable'
      endif
    endif
  endif
endif

if has('mksession')
  if isdirectory('~/local/.vim/tmp')
    set viewdir=~/local/.vim/tmp/view
  else
    set viewdir=~/.vim/tmp/view       " override ~/.vim/view default
  endif
  set viewoptions=cursor,folds        " save/restore just these (with `:{mk,load}view`)
endif

nmap <leader>s <C-p>
nnoremap <leader>p :CtrlPBuffer<cr>
nnoremap <leader># "*

set cursorline

cabbrev h vert h

let g:jsx_ext_required = 0

set conceallevel=0

