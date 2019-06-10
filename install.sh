#! /bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

function bdsemacs::install {
    local DOTEMACS="$HOME/.emacs"
    local DOTEMACSDOTD="$HOME/.emacs.d"
    local BACKUP="$HOME/Downloads/emacs_config_backup/$(date +%s)"

    if [[ -f "${DOTEMACS}" ]]; then
        mkdir -p ${BACKUP}
        mv ${DOTEMACS} ${BACKUP}
        echo -e "[ ${GREEN}ok${NC} ] Backup ${DOTEMACS} to ${BACKUP}."
    fi

    if [[ -d "${DOTEMACSDOTD}" ]]; then
        mkdir -p ${BACKUP}
        mv ${DOTEMACSDOTD} ${BACKUP}
        echo -e "[ ${GREEN}ok${NC} ] Backup ${DOTEMACSDOTD} to ${BACKUP}."
    fi

    # From https://stackoverflow.com/questions/59895/get-the-source-directory-of-a-bash-script-from-within-the-script-itself
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
    echo ${DIR}/dot.emacs.d
    ln -s ${DIR}/dot.emacs.d ${DOTEMACSDOTD}

    # Now, decide whether want to link epla/ for libraries as well.
    list=("No\nYes")
    choice=$(echo -e "$list" | dmenu -p "Link elpa as well? Recommend for Emacs 26+")
    if [[ "$choice" = "Yes" ]]; then
        ln -s ${DIR}/elpa26 ${DOTEMACSDOTD}/elpa
        echo -e "[ ${GREEN}ok${NC} ] Linked ${DOTEMACSDOTD}/elpa."
    fi
    
    if [[ -d "${DOTEMACSDOTD}" ]]; then
        echo -e "[${GREEN}done${NC}] Successfully installed."
    else
        echo -e "[${RED}FAIL${NC}] Installation abort."
    fi
}

bdsemacs::install
