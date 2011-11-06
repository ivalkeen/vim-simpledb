function! s:GetQuery()
  let query = ''
  let lines = getline(2,'$')
  for line in lines
    if line !~ '--.*'
      let query .= line . "\n"
    endif
  endfor
  return query
endfunction

function! s:ShowResults()
  let source_buf_nr = bufnr('%')

  if !exists('s:result_buf_nr')
    let s:result_buf_nr = -1
  endif

  if bufwinnr(s:result_buf_nr) > 0
    exec bufwinnr(s:result_buf_nr) . "wincmd w"
  else
    exec 'silent! botright ' . 'sview /tmp/vim-postgres-result.txt'
    let s:result_buf_nr = bufnr('%')
  endif

  exec bufwinnr(source_buf_nr) . "wincmd w"
endfunction

function! postgres#ExecuteSql()
  let conprops = matchstr(getline(1), '--\s*\zs.*')
  let query = s:GetQuery()
  let cmdline = 'echo -e ''\\timing on \\\ ' . escape(query, "\n") . "' | psql " . conprops
  silent execute '!(' . cmdline . ' > /tmp/vim-postgres-result.txt) 2> /tmp/vim-postgres-result.txt'
  call s:ShowResults()
  redraw!
endfunction
