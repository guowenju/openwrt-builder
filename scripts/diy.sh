#!/bin/bash

# 固件版本名称
package/base-files/files/usr/lib/os-release
#old
OPENWRT_RELEASE="%D %V %C" 
#new
OPENWRT_RELEASE="SFWWSLM %V %C"

# luci 界面名称
package/base-files/files/etc/openwrt_release
#old
DISTRIB_DESCRIPTION='%D %V %C'  
#new
DISTRIB_DESCRIPTION='SFWWSLM %V %C'

# 修改默认ip
package/base-files/files/bin/config_generate
#old
lan) ipad=${ipaddr:-"192.168.1.1"} ;;
*) ipad=${ipaddr:-"192.168.$((addr_offset++)).1"} ;;
#new
lan) ipad=${ipaddr:-"10.0.0.250"} ;;
*) ipad=${ipaddr:-"10.0.0.$((addr_offset++))"} ;;

# 基础系统配
package/base-files/files/bin/config_generate
#old
uci -q batch <<-EOF
    delete system.@system[0]
    add system system
    set system.@system[-1].hostname='OpenWrt'
    set system.@system[-1].timezone='GMT0'
    set system.@system[-1].zonename='UTC'
    set system.@system[-1].ttylogin='0'
    set system.@system[-1].log_size='128'
    set system.@system[-1].urandom_seed='0'

    delete system.ntp
    set system.ntp='timeserver'
    set system.ntp.enabled='1'
    set system.ntp.enable_server='0'
    add_list system.ntp.server='0.openwrt.pool.ntp.org'
    add_list system.ntp.server='1.openwrt.pool.ntp.org'
    add_list system.ntp.server='2.openwrt.pool.ntp.org'
    add_list system.ntp.server='3.openwrt.pool.ntp.org'
EOF
#new
uci -q batch <<-EOF
    delete system.@system[0]
    add system system
    set system.@system[-1].hostname='Main'  # 主机名修改这里
    set system.@system[-1].timezone='CST-8'  # 时区修改这里就好了, 原来这里是UTC
    set system.@system[-1].zonename='Asia/Shanghai'
    set system.@system[-1].ttylogin='0'
    set system.@system[-1].log_size='128'
    set system.@system[-1].urandom_seed='0'

    delete system.ntp
    set system.ntp='timeserver'
    set system.ntp.enabled='1'
    set system.ntp.enable_server='0'
    add_list system.ntp.server='ntp1.aliyun.com'
    add_list system.ntp.server='ntp.tencent.com'
    add_list system.ntp.server='ntp.ntsc.ac.cn'
    add_list system.ntp.server='time.apple.com'
EOF

# 构建产物的命名
include/version.mk
#old
VERSION_DIST:=$(if $(VERSION_DIST),$(VERSION_DIST),OpenWrt)
VERSION_MANUFACTURER:=$(if $(VERSION_MANUFACTURER),$(VERSION_MANUFACTURER),OpenWrt)
