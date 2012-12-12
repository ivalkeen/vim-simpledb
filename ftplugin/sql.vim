vnoremap <buffer> <enter> :call simpledb#ExecuteSql("'<", "'>")<cr>
nnoremap <buffer> <enter> :call simpledb#ExecuteSql("1", "$")<cr>
nnoremap <buffer> <leader><enter> :call simpledb#ExecuteSql("'{", "'}")<cr>
