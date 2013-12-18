#!/bin/sh

if [ "$1" = '--replace' -o "$1" = '-r' ]; then
    replace=1
fi

if [ "$1" = '--uninstall' -o "$1" = '-u' ]; then
    uninstall=1
fi

f=".Xresources"
i="vendor/xresources-hybrid/.Xresources-hybrid"
echo "Create symlink ${f} to ${HOME}..."
ln -s "`pwd`/${i}" "${HOME}/${f}"

for i in .*
do
    if [ ! -e ${i} ]; then
        continue
    fi

    f=`basename "${i}"`
    ignored=0
    for ignore in . .. .svn .git .gitmodules .DS_Store .zsh_history .ssh .virtualenvs
    do
        if [ "${f}" = "${ignore}" ]; then
            ignored=1
            continue
        fi
    done
    if [ "${ignored}" = "1" ]; then
        continue
    fi

    if [ -e "${HOME}/${f}" -o -h "${HOME}/${f}" ]; then
        echo "Already exist the dotfile ${f}."
        if [ "$replace" -o "$uninstall" ]; then
            echo "Remove ${f}"
            rm -rf "${HOME}/${f}"
        else
            continue
        fi
    fi
    if [ ! "$uninstall" ]; then
        echo "Create symlink ${f} to ${HOME}..."
        ln -s "`pwd`/${i}" "${HOME}/${f}"
    fi
done

# pip install --user git+git://github.com/Lokaltog/powerline

