export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export DISABLE_UPDATE_PROMPT=true
export EDITOR="vim"
export VISUAL="vim"
export KEYTIMEOUT=1
export PYTHON_CONFIGURE_OPTS="--enable-shared"
export CLICOLOR=YES
export ZSH_DOTENV_PROMPT=false
[[ "$(uname)" == "Darwin"  ]] && \
    export HOMEBREW_TEMP="/usr/local/tmp"
    export SDKROOT=/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk
    export LIBRARY_PATH="$LIBRARY_PATH:/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib"
    export JAVA_HOME=$(/usr/libexec/java_home -v 11.0.12)
