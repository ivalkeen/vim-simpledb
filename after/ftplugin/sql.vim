vmap <buffer> <enter> :call simpledb#ExecuteSql("'<", "'>")<cr>
nmap <buffer> <enter> :call simpledb#ExecuteSql("1", "$")<cr>
nmap <buffer> <leader><enter> :call simpledb#ExecuteSql("'{", "'}")<cr>
