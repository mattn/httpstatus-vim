command! -nargs=? HttpStatus echo join(httpstatus#filter(<q-args>),"\n")
