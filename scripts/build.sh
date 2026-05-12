#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

"${SCRIPT_DIR}/patch.sh"

rm -rf bin/

echo "🚀 开始编译..."

if ! PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin make V=99 -j"$1"
then
    echo "请检查错误信息并修复后再次执行脚本。"
    "${SCRIPT_DIR}/restore.sh"
    exit 1
fi

echo "✅ 编译完成！"

"${SCRIPT_DIR}/restore.sh"
