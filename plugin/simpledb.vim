if !exists('g:simpledb_show_timing') | let g:simpledb_show_timing = 1 | en

function! s:GetQuery(first, last)
  let query = ''
  let lines = getline(a:first, a:last)
  for line in lines
    let fragment = matchstr(line, '\(.*\)\(--.*\)\?')
    if !empty(fragment)
      let query .= fragment . "\n"
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
    exec 'silent! botright sview +setlocal\ noswapfile\ autoread /tmp/vim-simpledb-result.txt'
    let s:result_buf_nr = bufnr('%')
  endif

  exec bufwinnr(source_buf_nr) . "wincmd w"
endfunction

function! simpledb#ExecuteSql() range
  let conprops = matchstr(getline(1), '--\s*\zs.*')
  let adapter = matchlist(conprops, 'db:\(\w\+\)')
  let conprops = substitute(conprops, "db:\\w\\+", "", "")
  let query = s:GetQuery(a:firstline, a:lastline)

  if len(adapter) > 1 && adapter[1] == 'mysql'
    let cmdline = s:MySQLCommand(conprops, query)
  else
    let cmdline = s:PostgresCommand(conprops, query)
  endif

  silent execute '!(' . substitute(cmdline, "!", "\\\\!", "g") . ' > /tmp/vim-simpledb-result.txt) 2> /tmp/vim-simpledb-error.txt'
  silent execute '!(cat /tmp/vim-simpledb-error.txt >> /tmp/vim-simpledb-result.txt)'
  call s:ShowResults()
  redraw!
endfunction

function! s:MySQLCommand(conprops, query)
  let sql_text = shellescape(a:query)
  let sql_text = escape(sql_text, '%')
  let cmdline = 'echo -e ' . sql_text . '| mysql -v -v -v -t ' . a:conprops
  return cmdline
endfunction

function! s:PostgresCommand(conprops, query)
  if g:simpledb_show_timing == 1
    let sql_text = shellescape('\\timing on \\\ ' . a:query)
  else
    let sql_text = shellescape(a:query)
  end

  let sql_text = escape(sql_text, '%')
  let cmdline = 'echo -e ' . sql_text . '| psql ' . a:conprops
  return cmdline
endfunction

command! -range=% SimpleDBExecuteSql <line1>,<line2>call simpledb#ExecuteSql()
