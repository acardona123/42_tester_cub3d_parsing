#!/bin/bash

TIMEOUT_VALGRIND=5
TIMEOUT_CLASSIC=3

VALGRIND=0
CUB3D_PATH="."
ARGS=()

for arg in "$@"; do
    if [ "$arg" = "-v" ]; then
        VALGRIND=1
    else
        ARGS+=("$arg")
    fi
done

if [ "${#ARGS[@]}" -gt 1 ]; then
    echo "Usage: $0 [path_to_cub3d_dir] [-v]"
    exit 1
fi

if [ "${#ARGS[@]}" -eq 1 ]; then
    CUB3D_PATH="${ARGS[0]}"
fi

CUB3D_EXEC="$CUB3D_PATH/cub3D"
MAPS_DIR="invalid_maps"

echo "Testing $CUB3D_EXEC"

if [ ! -x "$CUB3D_EXEC" ]; then
    echo "Error: cub3D not found in the directory \"$CUB3D_PATH\" or not executable."
    exit 2
fi

if [ $VALGRIND -eq 1 ]; then
    echo "Valgrind mode enabled."
fi

total=0
passed=0
failed=0
leaked=0
failed_files=()
leaked_files=()

while IFS= read -r -d '' mapfile; do
    ((total++))

    if [ $VALGRIND -eq 1 ]; then
        timeout $TIMEOUT_VALGRIND valgrind --leak-check=full --error-exitcode=255 --exit-on-first-error=yes "$CUB3D_EXEC" "$mapfile" > /dev/null 2> /dev/null
        exit_code=$?
    else
        timeout $TIMEOUT_CLASSIC "$CUB3D_EXEC" "$mapfile" > /dev/null 2>&1
        exit_code=$?
    fi

    if [ $exit_code -eq 139 ]; then
        echo "[SEGV] $mapfile (segmentation fault)"
        ((failed++))
        failed_files+=("$mapfile")
    elif [ $exit_code -eq 124 ]; then
        echo "[FAIL] $mapfile (timeout)"
        ((failed++))
        failed_files+=("$mapfile")
    elif [ $exit_code -eq 255 ]; then
        echo "[VALGRIND ERROR] $mapfile (valgrind error detected: memory leak, invalid read/write, etc.)"
        ((leaked++))
        leaked_files+=("$mapfile")
        ((failed++))
        failed_files+=("$mapfile")
    elif [ $exit_code -ne 0 ]; then
        echo "[OK]   $mapfile"
        ((passed++))
    else
        echo "[FAIL] $mapfile (exit code $exit_code)"
        ((failed++))
        failed_files+=("$mapfile")
    fi
done < <(find "$MAPS_DIR" -type f -print0)

echo
echo "Tested $total files: $passed passed, $failed failed."
if [ $failed -ne 0 ]; then
    echo
    echo "Failed files:"
    for f in "${failed_files[@]}"; do
        echo "  $f"
    done
    echo "-> Test those files manually and discuss about those fail, some may just be due to a different interpretation of the subject."
    exit 1
else
    exit
fi
