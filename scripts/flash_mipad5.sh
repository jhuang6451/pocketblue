#!/usr/bin/env bash

set -uexo pipefail

which fastboot

echo 'waiting for device appear in fastboot'
fastboot getvar product 2>&1 | grep nabu

echo "Flashing images..."
echo "IMPORTANT: This script assumes you have already manually created the following partitions with the correct PARTLABELs:"
echo " - fedora_root"
echo " - linux_home"
echo " - fedora_boot"
echo " - esp"
echo " "

fastboot flash vbmeta_ab images/vbmeta_disabled.img
fastboot flash dtbo_ab images/dtbo.img
fastboot flash esp         images/esp.raw
fastboot flash fedora_boot images/boot.raw
fastboot flash fedora_root    images/root.raw

echo 'done flashing, rebooting now. if mipad5 not rebooted automatically, you should reboot it manually with power button'
fastboot reboot
