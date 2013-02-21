let s:save_cpo = &cpo
set cpo&vim

function! unite#sources#httpstatus#define()
  return s:source
endfunction

let s:source = {
\  "name" : "httpstatus",
\  "description" : "httpstatus",
\  "default_action" : "yank",
\  "action_table" : {
\    "yank" : {
\      "description" : "yank status",
\      "is_selectable" : 0,
\    },
\    "browser" : {
\      "description" : "open with browser",
\      "is_selectable" : 0,
\    },
\  }
\}

function! s:status_parse(str)
  let e = split(a:str, '^\d\+\zs:\s*')
  return {'code': e[0], 'message': e[1], 'abbr': a:str}
endfunction

function! s:source.gather_candidates(args, context)
  let status = map(httpstatus#filter(""), 's:status_parse(v:val)')
  return map(status, '{
        \ "abbr": v:val["abbr"],
        \ "word": v:val["abbr"],
        \ "action__httpstatus": v:val["abbr"],
        \ "action__browser": v:val["code"],
        \ }')
endfunction

function! s:source.action_table.yank.func(candidate)
  let @" = a:candidate.action__httpstatus
endfunction

function! s:source.action_table.browser.func(candidate)
  let url = get(g:, "unite_httpstatus_url", "http://www.studyinghttp.net/status_code#Code%s")
  call OpenBrowser(printf(url, a:candidate.action__browser))
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
