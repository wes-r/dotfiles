setlocal noexpandtab
setlocal nolist
" nmap <Leader>i <Plug>(go-info)

" Show go docs
nmap <Leader>gb <Plug>(go-doc-browser)
nmap <Leader>gd <Plug>(go-doc)
nmap <Leader>gv <Plug>(go-doc-vertical)

" Go to declaration for the word under the cursor
nmap gd <Plug>(go-def)

" Run go stuff
" nmap <Leader>t <Plug>(go-test)

" Restrict down to a column size of 80
setlocal colorcolumn=80