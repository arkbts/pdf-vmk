#!/bin/bash
benutzer=$(echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ && ! /loginwindow/ { print $3 }' )
eingang1="$(date +'%d. %B %Y')"
eingang2=$(date +'%y%m%d%H%M%S')
datei=$(echo "$1" | cut -f 1 -d '.')

tmpfile=$(mktemp)

echo "~color{0 0 0.5} $2 ~color{0.5 0 0} $eingang1 ~color{0 0 0} $3 --$benutzer" | \
enscript -q -e~ --margins=::-1: -B -f Arial-Bold10 -o- | ps2pdf - "$tmpfile"
    
qpdf --warning-exit-0 --no-warn $1 --overlay "$tmpfile" --repeat=1-z -- $datei"_"$2$eingang2".pdf"
