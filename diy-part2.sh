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


# 1. 修改常规的默认 IP 定义
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# 2. 修改板级定义的默认网络设置（针对新版源码的关键步骤）
# 这一步会替换 board.d 文件夹下可能存在的硬编码 IP
find package/base-files/files/etc/board.d/ -type f -exec sed -i 's/192.168.1.1/192.168.2.1/g' {} +
