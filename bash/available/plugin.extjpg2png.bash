function extjpg2png {
    for f in *.jpg ; do
        if [[ $(file -b --mime-type "$f") = image/png ]] ; then
            mv "$f" "${f/%.jpg/.png}"
        fi
    done
}
