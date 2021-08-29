let g:ale_linters = {'go': ['golangci-lint']}
let g:ale_go_golangci_lint_options = '--fast --enable=staticcheck --enable=gosimple --enable=unused'
let g:ale_go_golangci_lint_package = 1
