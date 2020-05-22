"https://vi.stackexchange.com/questions/16906/how-to-format-json-file-in-vim
function! FormatJson()
python3 << EOF
import vim
import json
try:
    buf = vim.current.buffer
    json_content = '\n'.join(buf[:])
    content = json.loads(json_content)
except ValueError as err:
    print('Invalid JSON file: {}'.format(err))
else:
    sorted_content = json.dumps(content, indent=4, sort_keys=True)
    buf[:] = sorted_content.split('\n')
EOF
endfunction
