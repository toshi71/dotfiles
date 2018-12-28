let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 0
inoremap <expr><Tab> pumvisible() ? "\<DOWN>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<UP>" : "\<S-Tab>"
