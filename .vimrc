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

let g:deoplete#sources#clang#libclang_path='/usr/local/Cellar/llvm/8.0.1/lib/libclang.dylib'
let g:deoplete#sources#clang#clang_header='/usr/local/Cellar/llvm/8.0.1/lib/clang/8.0.1'


function! Rnvar()
  let word_to_replace = expand("<cword>")
  let replacement = input("new name: ")
  execute '%s/\(\W\)' . word_to_replace . '\(\W\)/\1' . replacement . '\2/gc'
endfunction

nnoremap gr :call Rnvar()<Enter> 

nnoremap pf :Neoformat<Enter>

set number

set termguicolors

let g:material_terminal_italics = 1
let g:material_theme_style = 'default'
colorscheme material
