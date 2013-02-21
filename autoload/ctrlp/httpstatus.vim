if exists('g:loaded_ctrlp_httpstatus') && g:loaded_ctrlp_httpstatus
  finish
endif
let g:loaded_ctrlp_httpstatus = 1

let s:httpstatus_var = {
\  'init':   'ctrlp#httpstatus#init()',
\  'accept': 'ctrlp#httpstatus#accept',
\  'lname':  'httpstatus',
\  'sname':  'httpstatus',
\  'type':   'httpstatus',
\  'sort':   0,
\}

if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
  let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:httpstatus_var)
else
  let g:ctrlp_ext_vars = [s:httpstatus_var]
endif

function! ctrlp#httpstatus#init()
  return httpstatus#filter("")
endfunc

function! ctrlp#httpstatus#accept(mode, str)
  let e = split(a:str, '^\d\+\zs:\s*')
  call ctrlp#exit()
  let url = get(g:, "ctrlp_httpstatus_url", "http://www.studyinghttp.net/status_code#Code%s")
  call OpenBrowser(printf(url, e[0]))
endfunction

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#httpstatus#id()
  return s:id
endfunction

" vim:fen:fdl=0:ts=2:sw=2:sts=2
