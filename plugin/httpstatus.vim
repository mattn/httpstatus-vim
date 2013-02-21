command! -nargs=? HttpStatus echo join(httpstatus#filter(<q-args>),"\n")
command! CtrlPHttpStatus cal ctrlp#init(ctrlp#httpstatus#id())
