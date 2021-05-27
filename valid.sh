#!/bin/sh
if [ $# -ne 1 ];then
   printf '%s: error: need 1 arguments, got %d\n' "$0" "$#" >&2
   printf 'Example : %s <directory>' "$0" >&2
   exit 1
fi
echo "Validating json files in $1"
find $1 -name "*.json" -print0 | while IFS= read -d '' -r filename; do
    if ! jq . "$filename" >/dev/null 2>&1; then
        echo "$filename is invalid";exit 1
    fi
done
