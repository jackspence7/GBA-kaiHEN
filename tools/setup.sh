#!/bin/sh
# Clones the upstream sources this repo builds against into vendor/.
set -eu

REPO="$(cd "$(dirname "$0")/.." && pwd)"
mkdir -p "$REPO/vendor"
cd "$REPO/vendor"

clone() { # name url
    if [ -d "$1/.git" ]; then
        echo "==> $1 already present"
    else
        echo "==> cloning $1"
        git clone --depth 1 "$2" "$1"
    fi
}

clone mgba            https://github.com/mgba-emu/mgba.git
clone ounce-devkit    https://github.com/ouncebrew/ounce-devkit.git
clone libounce        https://github.com/ouncebrew/libounce.git
clone ouncevk         https://github.com/ouncebrew/ouncevk.git
clone kaihen          https://github.com/ouncebrew/kaihen.git
clone civ7-fs-kaihen  https://github.com/s8n/civ7-fs-kaihen.git

# Apply the Switch 2 display fix to the vendored mGBA (idempotent).
cd "$REPO/vendor/mgba"
if git apply --check "$REPO/tools/mgba-switch2-display.patch" 2>/dev/null; then
    git apply "$REPO/tools/mgba-switch2-display.patch"
    echo "==> applied tools/mgba-switch2-display.patch"
else
    echo "==> mgba-switch2-display.patch already applied (or no longer applies)"
fi

echo "==> vendor/ ready. Build the NRO with: tools/build.sh"
