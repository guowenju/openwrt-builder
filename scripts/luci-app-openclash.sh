#!/bin/bash
set -euo pipefail

rm -rf OpenClash
git clone --depth 1 https://github.com/vernesong/openclash.git OpenClash
rm -rf package/feeds/luci/luci-app-openclash
mv OpenClash/luci-app-openclash package/feeds/luci/luci-app-openclash
rm -rf OpenClash

##------------- meta core ---------------------------------
curl -sL -m 30 --retry 2 https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-amd64.tar.gz -o /tmp/clash.tar.gz
tar zxvf /tmp/clash.tar.gz -C /tmp >/dev/null 2>&1
chmod +x /tmp/clash >/dev/null 2>&1
mkdir -p package/feeds/luci/luci-app-openclash/root/etc/openclash/core
mv /tmp/clash package/feeds/luci/luci-app-openclash/root/etc/openclash/core/clash_meta >/dev/null 2>&1
rm -rf /tmp/clash.tar.gz >/dev/null 2>&1

##---------------------------------------------------------
##-------------- GeoIP 数据库 -----------------------------
curl -sL -m 30 --retry 2 https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat -o /tmp/GeoIP.dat
mv /tmp/GeoIP.dat package/feeds/luci/luci-app-openclash/root/etc/openclash/GeoIP.dat >/dev/null 2>&1

##---------------------------------------------------------
##-------------- GeoSite 数据库 ---------------------------
curl -sL -m 30 --retry 2 https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat -o /tmp/GeoSite.dat
mv /tmp/GeoSite.dat package/feeds/luci/luci-app-openclash/root/etc/openclash/GeoSite.dat >/dev/null 2>&1
