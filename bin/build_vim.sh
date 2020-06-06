#!/bin/bash
PYTHON_VERSION="3.7.5"
PYTHON_PATH="${PYENV_ROOT}/versions/${PYTHON_VERSION}/bin/python"
VIM_DIR="${HOME}/repos/vim"

test ! -d "$VIM_DIR"                    && mkdir -p "$VIM_DIR"

cd "$VIM_DIR"                                           || exit

test   -f "$PYTHON_PATH"                                || exit

test "$(pyenv local)" != "$PYTHON_VERSION"              || pyenv local "$PYTHON_VERSION" || exit

(test  -d "${VIM_DIR}/.git"             && git pull)    || git clone https://github.com/vim/vim

export CC=clang                         # clang over gcc
export CPPFLAGS="-D_FORTIFY_SOURCE=2"   # security hardeling (buffer overflow)
export MAKEFLAGS="-j4"                  # paralelized compilation
export CFLAGS="-march=native -O3 -pipe -fstack-protector --param=ssp-buffer-size=4"
export CXXFLAGS="${CFLAGS}"
export vi_cv_dll_name_python3="${PYENV_ROOT}/versions/${PYTHON_VERSION}/bin/python"

make distclean && ./configure   --prefix=/opt/vim           \
                                --enable-gui=no             \
                                --with-features=huge        \
                                --enable-multibyte          \
                                --enable-python3interp=yes  \
                                --enable-rubyinterp=dynamic \
                                --enable-perlinterp=dynamic \
                                --enable-luainterp=dynamic  \
                                --enable-cscope
make && sudo make install
