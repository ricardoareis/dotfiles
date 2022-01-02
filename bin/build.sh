#!/bin/bash
# use python constant to be consistent
PYTHON_VERSION="3.9.7"

function if_python() {
    local dir=$1
    shift

    cd "$dir" || exit

    python_local="$(pyenv local 2>/dev/null)"

    if [[ "$python_local" != "$PYTHON_VERSION" ]]; then
        echo "Defining PYENV local version to $PYTHON_VERSION"
        pyenv local "$PYTHON_VERSION" || exit
    fi
}

function build_vim() {
    export CC=clang                                   # clang over gcc
    export CPPFLAGS="$CPPFLAGS -D_FORTIFY_SOURCE=2"   # security hardeling (buffer overflow)
    export MAKEFLAGS="-j8"                            # paralelized compilation
    export CFLAGS="$CFLAGS -march=native -O3 -pipe"
    export CFLAGS="$CFLAGS -fstack-protector"
    export CFLAGS="$CFLAGS --param=ssp-buffer-size=4"
    export CXXFLAGS="$CXXFLAGS ${CFLAGS}"
    export LDFLAGS="$LDFLAGS -rdynamic"
    export vi_cv_dll_name_python3="$PYTHON_PATH"
    export STRIP=true                                 # workaround to avoid strip the vim binary
                                                      # in make install. Python in a striped vim binary
                                                      # does not work.
                                                      # https://github.com/vim/vim/issues/7551
    test ! -d "$VIM_DIR" && mkdir -p "$VIM_DIR"

    if_python "$VIM_DIR"

    cd "$VIM_DIR" || exit

    (test -d "${VIM_DIR}/.git" && git pull) || git clone https://github.com/vim/vim

    make clean distclean && ./configure --prefix=/opt/vim                                                        \
        --enable-gui=no                                                                                          \
        --with-features=huge                                                                                     \
        --enable-multibyte                                                                                       \
        --enable-python3interp=yes                                                                               \
        --enable-rubyinterp=dynamic                                                                              \
        --enable-perlinterp=dynamic                                                                              \
        --enable-luainterp=dynamic                                                                               \
        --enable-cscope
    make && sudo make install
}

function build_ycm() {
    cd "$YCM_DIR" || exit

    if_python "$YCM_DIR"

    (test -d "${YCM_DIR}/.git" && git pull) || exit

    python install.py --clangd-completer --go-completer --rust-completer --ts-completer \
        --java-completer
}

function usage() {
    local basename
    basename="$(basename "$0")"

    cat <<EOF
usage: $basename [options]

Options:
 vim    --      [https://github.com/vim/vi]
 ycm    --      [https://github.com/ycm-core/YouCompleteMe]

Ex.

$basename vim
EOF

    exit 127
}

function main() {
    VIM_DIR="${HOME}/repos/vim"
    YCM_DIR="${HOME}/.vim/bundles/YouCompleteMe"
    PYTHON_PATH="${PYENV_ROOT}/versions/${PYTHON_VERSION}/bin/python"

    if [[ ! -L "$PYTHON_PATH" ]]; then
        echo "Python $PYTHON_VERSION does not installed" && exit
    fi

    case "$1" in
    vim)
        build_vim
        ;;
    ycm)
        build_ycm
        ;;
    *)
        usage
        ;;
    esac
}

main "$@"
