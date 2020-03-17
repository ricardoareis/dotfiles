# Function: rationalize-path() ##{
# vim: set expandtab sw=4 ts=4 sts=4 et tw=78 ft=zsh foldmarker=##{,##} foldlevel=0 foldmethod=marker spell:
#
# Later we'll need to trim down the paths that follow because the ones
# given here are for all my accounts, some of which have unusual
# paths in them.  rationalize-path will remove
# nonexistent directories from an array.
getRationalizedPath() {
  #http://zsh.sourceforge.net/Contrib/startup/users/debbiep/dot.zshenv
  # Note that this works only on arrays, not colon-delimited strings.
  # Not that this is a problem now that there is typeset -T.
  local element
  local build
  build=()
  # Evil quoting to survive an eval and to make sure that
  # this works even with variables containing IFS characters, if I'm
  # crazy enough to setopt shwordsplit.
  eval '
  foreach element in "$'"$1"'[@]"
  do
    if [[ -d "$element" ]]
    then
      build=("$build[@]" "$element")
    fi
  done
  '"$1"'=( "$build[@]" )
  '
}
##}
