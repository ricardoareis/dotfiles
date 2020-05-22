export CC=clang                         # clang over gcc
export CPPFLAGS="-D_FORTIFY_SOURCE=2"   # security hardeling (buffer overflow)
export MAKEFLAGS="-j4"                  # paralelized compilation
export CFLAGS="-march=native -O3 -pipe -fstack-protector --param=ssp-buffer-size=4"
export CXXFLAGS="${CFLAGS}"
export python_version="3.7.5"
export vi_cv_dll_name_python3="${PYENV_ROOT}/versions/${python_version}/bin/python"

./configure --prefix=/opt/vim           \
            --enable-gui=no             \
            --with-features=huge        \
            --enable-multibyte          \
            --enable-python3interp=yes  \
            --enable-rubyinterp=dynamic \
            --enable-perlinterp=dynamic \
            --enable-luainterp=dynamic  \
            --enable-cscope
time make
