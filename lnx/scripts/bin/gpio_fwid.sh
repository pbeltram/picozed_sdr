#!/bin/sh

#Read Firmware ID: gpio_emio[15:0]
FRM_ID=0
for i in `seq 0 15` ; do 
  GPIO_IDX=$((906+54+$i))
  GPIO_VAL=`cat /sys/class/gpio/gpio${GPIO_IDX}/value`
  FRM_ID=$((${FRM_ID}+2**$i*${GPIO_VAL}))
done
echo "FirmwareID=${FRM_ID}"

