" vim: et sw=2 sts=2

" Plugin:      https://github.com/mhinz/vim-startify
" Description: A fancy start screen for Vim.
" Creator:  Marco Hinz <http://github.com/mhinz>
" Maintainer: Kat Flood <https://github.com/katawful>

if exists("b:current_syntax")
  finish
endif

let s:sep = v:lua.startify_fn_separator()
let s:raw_padding = v:lua.startify_value("left_padding", "format")
let s:padding_left = repeat(' ', s:raw_padding)

syntax sync fromstart

execute 'syntax match StartifyBracket /.*\%'. (len(s:padding_left) + 6) .'c/ contains=
      \ StartifyNumber,
      \ StartifySelect'
syntax match StartifySpecial /\V<empty buffer>\|<quit>/
syntax match StartifyNumber  /^\s*\[\zs[^BSVT]\{-}\ze\]/
syntax match StartifySelect  /^\s*\[\zs[BSVT]\{-}\ze\]/
syntax match StartifyVar     /\$[^\/]\+/
syntax match StartifyFile    /.*/ contains=
      \ StartifyBracket,
      \ StartifyPath,
      \ StartifySpecial,

execute 'syntax match StartifySlash /\'. s:sep .'/'
execute 'syntax match StartifyPath /\%'. (len(s:padding_left) + 6) .'c.*\'. s:sep .'/ contains=StartifySlash,StartifyVar'

" Header region was removed here in favor of extmarks

if exists('g:startify_custom_footer')
  execute 'syntax region StartifyFooter start=/\%'. v:lua.startify_lastline(bufnr()) .'l/ end=/\_.*/'
endif

" Section Titles was removed here in favor of extmarks

highlight default link StartifyBracket Delimiter
highlight default link StartifyFile    Identifier
highlight default link StartifyFooter  Title
highlight default link StartifyHeader  Title
highlight default link StartifyNumber  Number
highlight default link StartifyPath    Directory
highlight default link StartifySection Statement
highlight default link StartifySelect  Title
highlight default link StartifySlash   Delimiter
highlight default link StartifySpecial Comment
highlight default link StartifyVar     StartifyPath

let b:current_syntax = 'startify'
