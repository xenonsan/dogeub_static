#!/bin/bash

set -e

BASE_URL="https://storage.googleapis.com/canvas-lms/"

TMP_XML=$(mktemp)

curl -fsSL "$BASE_URL" -o "$TMP_XML"

grep -oP '(?<=<Key>).*?(?=</Key>)' "$TMP_XML" | while read -r file; do
    mkdir -p "$(dirname "$file")"

    echo "Downloading $file"
    curl -fsSL "$BASE_URL$file" -o "$file"
done

rm -f "$TMP_XML"

echo
echo "All files downloaded successfully."
