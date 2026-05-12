#!/bin/bash

echo "🧼 正在还原 OpenWRT 原始配置..."

# 还原默认 IP 地址
sed -i 's|lan) ipad=${ipaddr:-"10.0.0.250"} ;;|lan) ipad=${ipaddr:-"192.168.1.1"} ;;|' package/base-files/files/bin/config_generate
sed -i 's|*) ipad=${ipaddr:-"10.0.0.$((addr_offset++))"} ;;|*) ipad=${ipaddr:-"192.168.$((addr_offset++)).1"} ;;|' package/base-files/files/bin/config_generate

# 还原 config_generate 的系统信息
sed -i '/uci -q batch <<-EOF/,/EOF/ {
s|set system.@system\[-1\].timezone=.CST-8.|set system.@system[-1].timezone='\''GMT0'\''|
s|set system.@system\[-1\].zonename=.Asia/Shanghai.|set system.@system[-1].zonename='\''UTC'\''|
s|add_list system.ntp.server=.ntp1.aliyun.com.|add_list system.ntp.server='\''0.openwrt.pool.ntp.org'\''|
s|add_list system.ntp.server=.ntp.tencent.com.|add_list system.ntp.server='\''1.openwrt.pool.ntp.org'\''|
s|add_list system.ntp.server=.ntp.ntsc.ac.cn.|add_list system.ntp.server='\''2.openwrt.pool.ntp.org'\''|
s|add_list system.ntp.server=.time.apple.com.|add_list system.ntp.server='\''3.openwrt.pool.ntp.org'\''|
}' package/base-files/files/bin/config_generate

echo "✅ OpenWRT 配置还原完成。"
