#!/bin/sh

#Export Firmware ID: gpio_emio[15:0]
for i in `seq 0 15` ; do 
  GPIO_IDX=$((906+54+$i))
  echo ${GPIO_IDX} > /sys/class/gpio/export
done

#Export PushButton(S7,S8,S9): gpio_emio[18:16]
for i in `seq 16 18` ; do 
  GPIO_IDX=$((906+54+$i))
  echo ${GPIO_IDX} > /sys/class/gpio/export
done

#Export Fan output: gpio_emio[19]=$((906+54+19))
GPIO_IDX=$((906+54+19))
echo ${GPIO_IDX} > /sys/class/gpio/export
echo out > /sys/class/gpio/gpio${GPIO_IDX}/direction
echo 1 > /sys/class/gpio/gpio${GPIO_IDX}/value

#Export Fan spin: gpio_emio[20]=$((906+54+20))
GPIO_IDX=$((906+54+20))
echo ${GPIO_IDX} > /sys/class/gpio/export

#Export up_enable: gpio_emio[47]=$((906+54+47))
#GPIO_IDX=$((906+54+47))
#echo ${GPIO_IDX} > /sys/class/gpio/export
#echo out > /sys/class/gpio/gpio${GPIO_IDX}/direction
#echo 0 > /sys/class/gpio/gpio${GPIO_IDX}/value

#Export up_txnrx: gpio_emio[48]=$((906+54+48))
#GPIO_IDX=$((906+54+48))
#echo ${GPIO_IDX} > /sys/class/gpio/export
#echo out > /sys/class/gpio/gpio${GPIO_IDX}/direction
#echo 0 > /sys/class/gpio/gpio${GPIO_IDX}/value

