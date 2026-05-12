#!/bin/bash
set -euo pipefail

git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon.git
rm -rf package/feeds/luci/luci-theme-argon
mv luci-theme-argon package/feeds/luci/luci-theme-argon
