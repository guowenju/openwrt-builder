# 编译 OpenWrt

- 16MiB/512MiB

## 配置

```text
Administration  ---> htop

Kernel modules  --->  Wireless Drivers  ---> kmod-mt7921e
Kernel modules  --->  Wireless Drivers  ---> kmod-mt7922-firmware

LuCI --->  Collections  --->  luci

LuCI --->  Modules  --->  Translations  --->  Chinese Simplified (zh_Hans) (NEW)
LuCI --->  Modules  --->  luci-mod-dashboard

LuCI ---> Applications ---> luci-app-openclash
LuCI ---> Applications ---> luci-app-wol

LuCI ---> Themes ---> luci-theme-argon

Network --->  WirelessAPD  --->  hostapd-openssl
Network --->  iperf3
Network --->  wakeonlan

Utilities  --->  Virtualization  --->  qemu-ga
```
