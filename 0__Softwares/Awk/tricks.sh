awk 'NR%2{printf "%s ",$0;next;}1' yourFile


awk '{key=$0; getline; print key ", " $0;}'


awk 'ORS=NR%2?FS:RS' file

awk '{ ORS = (NR%2 ? FS : RS) } 1' file

awk '{ ORS = (NR%2 ? "," : RS) } 1' file