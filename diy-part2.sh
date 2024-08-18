#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# https://github.com/yegetables/openwrt/commit/40aa642f3b8228c2bd9bb42d971b5a12737bbe66
    # 获取脚本文件的绝对路径
SCRIPT_PATH=$(readlink -f "$0")
    # 获取脚本文件所在的目录
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")
echo "当前脚本文件所在的路径是: $SCRIPT_DIR"



# Modify default IP
sed -i 's/192.168.1.1/192.168.0.201/g' package/base-files/files/bin/config_generate
line1="				set network.\$1.gateway='192.168.0.1'"
line2="				set network.\$1.dns='127.0.0.1 192.168.0.1 8.8.8.8'"
sed -i "/set network.\$1.netmask='\$netm'/a\\
$line1\\
$line2" package/base-files/files/bin/config_generate

# Modify hostname
sed -i 's/OpenWrt/yegetables-op/g' package/base-files/files/bin/config_generate

# banner
cp $SCRIPT_DIR/banner.txt package/base-files/files/etc/banner


# passwd
sed -i 's/root:::0:99999:7:::/root:$1$Ia9dBEx1$Pf.w.p0k5ue.E2A3w7o6N0:19950:0:99999:7:::/g' package/base-files/files/etc/shadow

#  WIFI SSID
sed -i 's/ssid="OpenWrt"/ssid="OpenWrt-yegatbles"/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
