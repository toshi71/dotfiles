autocmd BufWritePost *.hs call s:check_and_lint()
function! s:check_and_lint()
  let l:qflist = ghcmod#make('check', expand('%'))
  call extend(l:qflist, ghcmod#make('lint', expand('%')))
  call setqflist(l:qflist)
  cwindow
  if empty(l:qflist)
    echo "No errors found"
  endif
endfunction
