function! s:GetQuery()
  let query = ''
  let lines = getline("'<","'>")
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
    exec 'silent! botright ' . 'sview /tmp/vim-simpledb-result.txt'
    let s:result_buf_nr = bufnr('%')
  endif

  exec bufwinnr(source_buf_nr) . "wincmd w"
endfunction

function! simpledb#ExecuteSql()
  let conprops = matchstr(getline(1), '--\s*\zs.*')
  let adapter = matchlist(conprops, 'db:\(\w\+\)')
  let conprops = substitute(conprops, "db:\\w\\+", "", "")

  if len(adapter) > 1 && adapter[1] == 'mysql'
    let cmdline = s:MySQLCommand(conprops)
  else
    let cmdline = s:PostgresCommand(conprops)
  endif

  silent execute '!(' . cmdline . ' > /tmp/vim-simpledb-result.txt) 2> /tmp/vim-simpledb-result.txt'
  call s:ShowResults()
  redraw!
endfunction

function! s:MySQLCommand(conprops)
  let sql_text = shellescape(s:GetQuery())
  let sql_text = escape(sql_text, '%')
  let cmdline = 'echo -e ' . sql_text . '| mysql -v -v -v -t ' . a:conprops
  return cmdline
endfunction

function! s:PostgresCommand(conprops)
  let sql_text = shellescape('\\timing on \\\ ' . s:GetQuery())
  let sql_text = escape(sql_text, '%')
  let cmdline = 'echo -e ' . sql_text . '| psql ' . a:conprops
  return cmdline
endfunction

