#!/bin/bash

# Root directory (default = current directory)
ROOT_DIR="${1:-.}"

echo "Project Structure Check:"
echo "------------------------"

# Recursive function
check_item() {
    local item="$1"
    local indent="$2"

    if [ -d "$item" ]; then
        # Directory
        if [ -z "$(ls -A "$item")" ]; then
            echo "${indent}📁 $(basename "$item") - EMPTY"
        else
            size=$(du -sh "$item" 2>/dev/null | cut -f1)
            echo "${indent}📁 $(basename "$item") - $size"
            for subitem in "$item"/*; do
                check_item "$subitem" "    $indent"
            done
        fi

    elif [ -f "$item" ]; then
        # File
        size=$(stat -c%s "$item")
        if [ "$size" -eq 0 ]; then
            echo "${indent}📄 $(basename "$item") - EMPTY"
        else
            human_size=$(du -h "$item" | cut -f1)
            echo "${indent}📄 $(basename "$item") - $human_size"
        fi
    fi
}

check_item "$ROOT_DIR" ""
