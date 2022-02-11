system_type=$(uname -s)

if [ "$system_type" = "Darwin" ]; then
    eval "$(pyenv init --path)"
else
    if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
        exec ssh-agent startx
    fi
fi
