function! GetQuery()
  let query = ''
  let lines = getline(2,'$')

  for line in lines
    if line !~ '--.*'
      let query .= line . "\n"
    endif
  endfor
  return query
endfunction

function! ExecuteSql()
  let conprops = matchstr(getline(1), '--\s*\zs.*')
  let query = GetQuery()

  let cmdline = "psql " . conprops . " -c " . shellescape(query)

  silent execute '!(' . cmdline . ' > ~/tmp/result.txt) 2> ~/tmp/result.txt'
  redraw!

  "echo cmdline
endfunction
