#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate
#sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate


# 1. 深度修改默认 IP (从 192.168.1.1 改为 192.168.2.1)
# 涵盖 config_generate 和所有基础配置文件
find package/base-files/files/ -type f -exec sed -i 's/192.168.1.1/192.168.2.1/g' {} +

# 2. 修改默认主机名 (从 OpenWrt 改为 Phicomm-K3)
sed -i 's/OpenWrt/Phicomm-K3/g' package/base-files/files/bin/config_generate

# 3. 修正 automount 的 Makefile 依赖，解决 K3 等平台下的编译冲突
if [ -f package/lean/automount/Makefile ]; then
    sed -i 's/+!TARGET_ramips:kmod-usb-storage-uas //g' package/lean/automount/Makefile
fi

# 4. 如果有 K3 屏幕插件，也尝试修正其显示的默认 IP (可选)
find package/ -type f -name "*k3screenctrl*" | xargs sed -i 's/192.168.1.1/192.168.2.1/g' 2>/dev/null || true
