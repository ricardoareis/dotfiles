# Function: getUniqueFolder ##{
# vim: set expandtab sw=4 ts=4 sts=4 et tw=78 ft=zsh foldmarker=##{,##} foldlevel=0 foldmethod=marker spell:
getUniqueFolder() {
    local trunc_path directory test_dir test_dir_length
    local -a matching
    local -a paths
    local cur_path='/'
    paths=(${(s:/:)1})
    for directory in ${paths[@]}; do
        test_dir=''
        for (( i=0; i < ${#directory}; i++ )); do
            test_dir+="${directory:$i:1}"
            matching=("$cur_path"/"$test_dir"*/)
            if [[ ${#matching[@]} -eq 1 ]]; then
                break
            fi
        done
        trunc_path+="$test_dir/"
        cur_path+="$directory/"
    done
    echo "${${trunc_path: : -1}/h\/m/"~"}"
}
##}
