#!/bin/sh
# Builds mGBA as a native Switch 2 NRO for kaiHEN.
#
# Usage:  tools/build.sh
# Output: dist/mgba.nro  (copy to SD card /switch/mgba.nro, launch from hbmenu)
#
# Requires Docker. The ounce-devkit toolchain image is built on first run.
set -eu

REPO="$(cd "$(dirname "$0")/.." && pwd)"
IMAGE="${OUNCE_IMAGE:-ounce-devkit}"
MGBA="$REPO/vendor/mgba"

# 1. Build the toolchain image if it isn't already present.
if ! docker image inspect "$IMAGE" >/dev/null 2>&1; then
    echo "==> Building $IMAGE toolchain image (first run only)..."
    docker build -t "$IMAGE" "$REPO/vendor/ounce-devkit"
fi

# 2. Drop our Switch 2 toolchain into the mGBA tree.
cp "$REPO/tools/CMakeToolchain2.txt" "$MGBA/src/platform/switch/CMakeToolchain2.txt"

# 3. Configure + build inside the container (fresh build dir each time).
docker run --rm -v "$REPO:/work" -w /work/vendor/mgba "$IMAGE" sh -c '
    set -e
    rm -rf build-switch2
    cmake -S . -B build-switch2 \
        -DCMAKE_TOOLCHAIN_FILE=src/platform/switch/CMakeToolchain2.txt \
        -DCMAKE_BUILD_TYPE=Release
    cmake --build build-switch2 --target mgba.nro -j"$(nproc)"
'

# 4. Pull the NRO out of the container's mount.
mkdir -p "$REPO/dist"
cp "$MGBA/build-switch2/switch/mgba.nro" "$REPO/dist/mgba.nro"
echo "==> Built $REPO/dist/mgba.nro"
