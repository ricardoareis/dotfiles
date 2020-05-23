function! DecodeB64()
let register = @"
let result = register

python3 << EOF
import vim
import base64
import binascii

try:
    buf = vim.eval("register")
    buf_decoded = base64.b64decode(buf)
    buf_decoded = buf_decoded.decode('utf-8')
except binascii.Error as err:
    print('Invalid B64 string: {}'.format(err.args))
else:
    vim.command("let result=py3eval('buf_decoded')")
EOF
    return result
endfunction
