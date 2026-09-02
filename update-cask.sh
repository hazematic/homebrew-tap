#!/bin/bash
# Setzt Version und Prüfsumme im Cask aus einem gebauten Release-ZIP.
#
#   ./update-cask.sh ../pegel/build/Pegel-0.1.0.zip
#
# Die Version wird aus dem Dateinamen gelesen. Danach committen und pushen, mehr
# braucht ein Release im Tap nicht.
set -euo pipefail

ZIP="${1:?Pfad zum Release-ZIP fehlt}"
[ -f "$ZIP" ] || { echo "Nicht gefunden: $ZIP" >&2; exit 1; }

BASENAME="$(basename "$ZIP")"
VERSION="${BASENAME#Pegel-}"
VERSION="${VERSION%.zip}"
SHA="$(shasum -a 256 "$ZIP" | cut -d' ' -f1)"

cd "$(dirname "$0")"
/usr/bin/sed -i '' \
    -e "s/^  version \".*\"$/  version \"$VERSION\"/" \
    -e "s/^  sha256 \".*\"$/  sha256 \"$SHA\"/" \
    Casks/pegel.rb

echo "Cask auf $VERSION gesetzt"
echo "  sha256 $SHA"
