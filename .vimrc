imap <F6> <Esc>:tabp<Enter>I
imap <F7> <Esc>:tabn<Enter>I
nmap <F6> <Esc>:tabp<Enter>
nmap <F7> <Esc>:tabn<Enter>
tnoremap <Esc> <C-\><C-n>

set mouse=a

call plug#begin()
Plug 'sbdchd/neoformat'
Plug 'maralla/completor.vim'
Plug 'zchee/deoplete-clang'
Plug 'neomake/neomake'
Plug 'itchyny/lightline.vim'
Plug 'kaicataldo/material.vim'
Plug 'tpope/vim-fugitive'
call plug#end()

function! Tab_Or_Complete() abort
  " If completor is already open the `tab` cycles through suggested completions.
  if pumvisible()
    return "\<C-N>"
  " If completor is not open and we are in the middle of typing a word then
  " `tab` opens completor menu.
  elseif col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^[[:keyword:][:ident:]]'
    return "\<C-R>=completor#do('complete')\<CR>"
  else
    " If we aren't typing a word and we press `tab` simply do the normal `tab`
    " action.
    return "\<Tab>"
  endif
endfunction

let g:completor_auto_trigger = 1
inoremap <expr> <Tab> Tab_Or_Complete()

let g:deoplete#sources#clang#libclang_path='/usr/lib/libclang.so.11'
let g:deoplete#sources#clang#clang_header='/usr/lib/clang/11.0.0/include/'

function! Rnvar()
  let word_to_replace = expand("<cword>")
  let replacement = input("new name: ")
  execute '%s/\(\W\)' . word_to_replace . '\(\W\)/\1' . replacement . '\2/gc'
endfunction

nnoremap gr :call Rnvar()<Enter> 
nnoremap pf :Neoformat<Enter>

function! UseTabs()
  set tabstop=4     " Size of a hard tabstop (ts).
  set shiftwidth=4  " Size of an indentation (sw).
  set noexpandtab   " Always uses tabs instead of space characters (noet).
  set autoindent    " Copy indent from current line when starting a new line (ai).
endfunction

function! UseSpaces()
  set tabstop=2     " Size of a hard tabstop (ts).
  set shiftwidth=2  " Size of an indentation (sw).
  set expandtab     " Always uses spaces instead of tab characters (et).
  set softtabstop=0 " Number of spaces a <Tab> counts for. When 0, featuer is off (sts).
  set autoindent    " Copy indent from current line when starting a new line.
  set smarttab      " Inserts blanks on a <Tab> key (as per sw, ts and sts).
endfunction

au! BufNewFile,BufRead *.vue,*.js call UseSpaces()

set number
set termguicolors

let g:material_terminal_italics = 1
let g:material_theme_style = 'default'
colorscheme material
