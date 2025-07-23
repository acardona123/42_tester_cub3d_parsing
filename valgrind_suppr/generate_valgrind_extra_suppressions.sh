#!/bin/bash
# Usage: ./make_valgrind_supp.sh <executable> <suppression_name>

if [ $# -ne 2 ]; then
    echo "Usage: $0 <executable> <suppression_name>"
    exit 1
fi

EXEC="$1"
NAME="$2"
SUPP_FILE="valgrind_suppr_${NAME}.supp"

valgrind --leak-check=full --gen-suppressions=all --log-file=valgrind.log "$EXEC"

awk '/^{/,/^}/ {print}' valgrind.log | sed "s/<insert_a_suppression_name_here>/$NAME/" > "$SUPP_FILE"

rm valgrind.log

echo "--suppressions=\"valgrind_suppr/$SUPP_FILE\"" >> ../valgrindrc

echo "Suppressions saved to $SUPP_FILE"