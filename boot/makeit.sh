#!/bin/sh

rm *.img
rm zImage
echo "Old files removed"
echo "Specify kernel version:"
read ver2
kv=$ver2
echo "Copying kernel image and generating dt image"
cp /home/lozohcum/kernel/arch/arm/boot/zImage /home/lozohcum/kernel/boot/zImage
./dtbToolCM --force-v2 -o dt.img -s 2048 -p /home/lozohcum/kernel/scripts/dtc/ /home/lozohcum/kernel/arch/arm/boot/
echo "Making boot image 'SimpleKernelX"${ver2}".img'"

./mkbootimg --base 0x00000000 --kernel zImage --ramdisk_offset 0x02300000 --tags_offset 0x01E00000 --pagesize 2048 --ramdisk ramdisk.cpio.gz --dt dt.img -o SimpleKernelX${ver2}.img --cmdline "console=ttyHSL0,115200,n8 androidboot.console=ttyHSL0 androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x37"
