#!/bin/bash
MODULE="$1"
EXTRA="/etc/httpd/conf.modules.d/99-extra.conf"
MODULE_FILES=`grep -IPr "^(\s*##*\s*)(LoadModule\s\s*${MODULE}_module\s\s*modules\/mod_${MODULE}\.so)" /etc/httpd | cut -d":" -f1 | tr "\n" " "`

if [ "${MODULE_FILES}" != "" ]; then
    for MODULE_FILE in ${MODULE_FILES}; do
        echo "[+] Enabling ${MODULE}_module in ${MODULE_FILE}"
        sed -i -e "s/^\(\s*##*\s*\)\(LoadModule\s\s*${MODULE}_module\s\s*modules\/mod_${MODULE}\.so\)/\2/g" ${MODULE_FILE}
    done
else
    MODULE_FILES=`grep -IPr "^(\s*)(LoadModule\s\s*${MODULE}_module\s\s*modules\/mod_${MODULE}\.so)" /etc/httpd | cut -d":" -f1 | tr "\n" " "`
    if [ "${MODULE_FILES}" != "" ]; then
        for MODULE_FILE in ${MODULE_FILES}; do
            echo "[+] Module ${MODULE}_module already enabled in ${MODULE_FILE}"
        done
    else
        echo "[+] Enabling ${MODULE}_module in ${EXTRA}"
        echo "LoadModule ${MODULE}_module modules/mod_${MODULE}.so" >> ${EXTRA}
    fi
fi
