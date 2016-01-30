# Replace new lines temporarily
# http://unix.stackexchange.com/questions/114943/can-sed-replace-new-line-characters
:a;N;$!ba;s/\n/¡/g
# Find the pattern
s/\\bibitem{\([[:alpha:]]*\([[:digit:]]\{4\}\)[^}]*\)}¡\\BIBentryALTinterwordspacing¡\([^¡]*\)¡/\\bibitem{\1}¡\\BIBentryALTinterwordspacing¡\3\\years{\2}\¡/gp
# Rewrite new line characters
s/¡/\n/g

