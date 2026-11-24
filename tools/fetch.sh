#!/usr/bin/env bash
# 拉 LVGL v9.6.0 到 src/lvgl。
#   bash tools/fetch.sh
# 环境变量：IM6_SRC / IM6_LV_URL / IM6_FORCE=1
set -euo pipefail

ROOT=$(cd "$(dirname "$0")/.." && pwd)
SRC=${IM6_SRC:-$ROOT/vendor}
LV_TAG=v9.6.0
LV_URL=${IM6_LV_URL:-https://github.com/lvgl/lvgl.git}
: "${IM6_FORCE:=0}"

mkdir -p "$SRC"
if [ ! -f "$SRC/lvgl/lv_version.h" ] || [ "$IM6_FORCE" = 1 ]; then
  echo "== 克隆 LVGL $LV_TAG =="
  rm -rf "$SRC/lvgl"
  git clone --depth 1 --branch "$LV_TAG" "$LV_URL" "$SRC/lvgl"
else
  echo "== 复用已有 LVGL 源码 =="
  grep -m1 'LVGL_VERSION' "$SRC/lvgl/lv_version.h" || true
fi
echo "源码就绪：$SRC/lvgl"
