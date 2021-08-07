function! PrettyXML()
  silent %!xmllint --format --encode UTF-8 --recover - 2>/dev/null
endfunction

command! PrettyXML call PrettyXML()
