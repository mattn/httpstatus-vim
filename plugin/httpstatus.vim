command! -nargs=1 HttpStatus echo join(httpstatus#filter(<q-args>),"\n")
