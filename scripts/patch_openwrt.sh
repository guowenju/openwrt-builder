#!/bin/bash
set -e

echo "🔧 正在修改 OpenWRT 配置..."

# 修改 os-release
# sed -i 's|OPENWRT_RELEASE="%D %V %C"|OPENWRT_RELEASE="sfwwslm %V %C"|' package/base-files/files/usr/lib/os-release

# 修改 luci 界面名称
# sed -i "s|DISTRIB_DESCRIPTION='%D %V %C'|DISTRIB_DESCRIPTION='sfwwslm %V %C'|" package/base-files/files/etc/openwrt_release

# 修改默认 IP 地址
sed -i 's|lan) ipad=${ipaddr:-"192.168.1.1"} ;;|lan) ipad=${ipaddr:-"10.0.0.250"} ;;|' package/base-files/files/bin/config_generate
sed -i 's|*) ipad=${ipaddr:-"192.168.$((addr_offset++)).1"} ;;|*) ipad=${ipaddr:-"10.0.0.$((addr_offset++))"} ;;|' package/base-files/files/bin/config_generate

# 修改 config_generate 的系统信息
sed -i '/uci -q batch <<-EOF/,/EOF/ {
s|set system.@system\[-1\].timezone=.GMT0.|set system.@system[-1].timezone='\''CST-8'\''|
s|set system.@system\[-1\].zonename=.UTC.|set system.@system[-1].zonename='\''Asia/Shanghai'\''|
s|add_list system.ntp.server=.0.openwrt.pool.ntp.org.|add_list system.ntp.server='\''ntp1.aliyun.com'\''|
s|add_list system.ntp.server=.1.openwrt.pool.ntp.org.|add_list system.ntp.server='\''ntp.tencent.com'\''|
s|add_list system.ntp.server=.2.openwrt.pool.ntp.org.|add_list system.ntp.server='\''ntp.ntsc.ac.cn'\''|
s|add_list system.ntp.server=.3.openwrt.pool.ntp.org.|add_list system.ntp.server='\''time.apple.com'\''|
}' package/base-files/files/bin/config_generate

# 修改版本命名
# sed -i 's|VERSION_DIST:=$(if $(VERSION_DIST),$(VERSION_DIST),OpenWrt)|VERSION_DIST:=$(if $(VERSION_DIST),$(VERSION_DIST),sfwwslm)|' include/version.mk

# sed -i 's|VERSION_MANUFACTURER:=$(if $(VERSION_MANUFACTURER),$(VERSION_MANUFACTURER),OpenWrt)|VERSION_MANUFACTURER:=$(if $(VERSION_MANUFACTURER),$(VERSION_MANUFACTURER),sfwwslm)|' include/version.mk

# sed -i "s|OpenWrt)|sfwwslm)|" include/version.mk

echo "✅ OpenWRT 配置修改完成。"
