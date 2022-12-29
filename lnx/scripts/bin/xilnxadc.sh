#!/bin/sh

ADCIIO_DEVICE="device3"

# Arguments sanity check
[ $# -lt 1 ] && {
    echo "Usage: $0 <xilinx_adc_iio>"
    echo "   xilinx_adc_iio: ADC IIO deviceN (e.g. /sys/bus/iio/devices/iio:${ADCIIO_DEVICE})."
    exit 1
}
[ $# -gt 1 ] && {
    echo "Usage: $0 <xilinx_adc_iio>"
    echo "   xilinx_adc_iio: ADC IIO deviceN (e.g. /sys/bus/iio/devices/iio:${ADCIIO_DEVICE})."
    exit 1
}

XILINX_ADCIIO=/sys/bus/iio/devices/iio:$1

function read_temp()
{
    VAL=$1
    OFS=`cat ${XILINX_ADCIIO}/in_${VAL}_offset`
    RAW=`cat ${XILINX_ADCIIO}/in_${VAL}_raw`
    SCALE=`cat ${XILINX_ADCIIO}/in_${VAL}_scale`
    RES=`echo - | awk "{print $SCALE*($RAW+$(($OFS)))}"`
    echo "$VAL=$RES mC"
}

function read_vcc()
{
    VAL=$1
    RAW=`cat ${XILINX_ADCIIO}/in_${VAL}_raw`
    SCALE=`cat ${XILINX_ADCIIO}/in_${VAL}_scale`
    RES=`echo - | awk "{print $SCALE*$RAW}"`
    echo "$VAL=$RES mV"
}

cat ${XILINX_ADCIIO}/name

read_temp "temp0"

read_vcc "voltage0_vccint"
read_vcc "voltage1_vccaux"
read_vcc "voltage2_vccbram"
read_vcc "voltage3_vccpint"
read_vcc "voltage4_vccpaux"
read_vcc "voltage5_vccoddr"
read_vcc "voltage6_vrefp"
read_vcc "voltage7_vrefn"

