#!/bin/bash
# Sets version and checksum in the cask from a release ZIP.
#
#   ./update-cask.sh ../pegel/build/Pegel-0.1.0.zip
set -euo pipefail

ZIP="${1:?path to release ZIP missing}"
[ -f "$ZIP" ] || { echo "Not found: $ZIP" >&2; exit 1; }

BASENAME="$(basename "$ZIP")"
VERSION="${BASENAME#Pegel-}"
VERSION="${VERSION%.zip}"
SHA="$(shasum -a 256 "$ZIP" | cut -d' ' -f1)"

cd "$(dirname "$0")"
/usr/bin/sed -i '' \
    -e "s/^  version \".*\"$/  version \"$VERSION\"/" \
    -e "s/^  sha256 \".*\"$/  sha256 \"$SHA\"/" \
    Casks/pegel.rb

echo "Cask set to $VERSION"
echo "  sha256 $SHA"
