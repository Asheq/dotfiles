# TODO: Go back to using dirvish
export NNN_TMPFILE="/tmp/nnn"

n() {
        nnn -l "$@"

        if [[ -f $NNN_TMPFILE ]]; then
                . $NNN_TMPFILE
                rm -f $NNN_TMPFILE > /dev/null
        fi
}