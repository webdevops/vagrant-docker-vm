#!/usr/bin/env bash

export DEBIAN_FRONTEND="noninteractive"

PACKAGE_LIST=""

# Build list of packages with missing manpages
for p in $(dpkg-query -f '${Package} ' -W); do
     while read file; do
        if [[ "$file" == '/usr/share/man/'* ]] && [[ ! -e "$file" ]]; then
                #apt-get install --reinstall -- "$p"
                PACKAGE_LIST="$PACKAGE_LIST $p"
                break
        fi
    done <<< "$(dpkg -L "$p" | grep '^/')"
done

# Reinstall packages
if [[ -n "$PACKAGE_LIST" ]]; then
    PACKAGE_LIST=$(echo "$PACKAGE_LIST" | sort | uniq)
    echo "$PACKAGE_LIST" | xargs apt-get -q -y install --reinstall --
    apt-get clean
fi
