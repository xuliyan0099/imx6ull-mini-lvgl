#!/usr/bin/env bash
# 交叉编译静态仪表盘，产物 ./lvgl_demo（849 KB 级）。
#   bash tools/build.sh
# 环境变量：IM6_SRC / IM6_CROSS
set -euo pipefail

ROOT=$(cd "$(dirname "$0")/.." && pwd)
SRC=${IM6_SRC:-$ROOT/vendor}
CROSS=${IM6_CROSS:-arm-linux-gnueabihf-}
LVGL_DIR=${LVGL_DIR:-$SRC/lvgl}

command -v "${CROSS}gcc" >/dev/null || { echo "缺少 ${CROSS}gcc" >&2; exit 1; }
[ -f "$LVGL_DIR/lv_version.h" ] || bash "$ROOT/tools/fetch.sh"

make -C "$ROOT" clean static CC="${CROSS}gcc" STRIP="${CROSS}strip" LVGL_DIR="$LVGL_DIR"
ls -l "$ROOT/lvgl_demo"
sha256sum "$ROOT/lvgl_demo"
