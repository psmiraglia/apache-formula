#!/bin/bash
MODULE="$1"
MODULE_FILES=`grep -IPr "^(\s*)(LoadModule\s\s*${MODULE}_module\s\s*modules\/mod_${MODULE}\.so)" /etc/httpd | cut -d":" -f1 | tr "\n" " "`
if [ "${MODULE_FILES}" != "" ]; then
    for MODULE_FILE in ${MODULE_FILES}; do
        if [ "${MODULE_FILE}" != "" ]; then
            echo "[+] Disabling ${MODULE}_module in ${MODULE_FILE}"
            sed -i -e "s/\(\s*\)\(LoadModule\s\s*${MODULE}_module\s\s*modules\/mod_${MODULE}\.so\)/#\2/g" ${MODULE_FILE}
        fi
    done
else
    echo "[+] Module ${MODULE}_module already disabled"
fi
