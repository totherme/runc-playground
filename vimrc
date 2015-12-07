set nocompatible
set number
map ,a :%!python -m json.tool<cr>
map <cr> :w<cr>
nnoremap <silent> <C-l> <c-w>l
nnoremap <silent> <C-h> <c-w>h
nnoremap <silent> <C-k> <c-w>k
nnoremap <silent> <C-j> <c-w>j

