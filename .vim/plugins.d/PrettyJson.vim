"https://vi.stackexchange.com/questions/16906/how-to-format-json-file-in-vim
"TODO: Refactoring
function! FormatJson()
python3 << EOF
import vim
import json
try:
    buf = vim.current.buffer
    json_content = '\n'.join(buf[:])
    content = json.loads(json_content)
    sorted_content = json.dumps(content, indent=4, sort_keys=True)
    buf[:] = sorted_content.split('\n')
except Exception as err:
    print(err)
EOF
endfunction
