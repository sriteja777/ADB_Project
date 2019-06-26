#!/usr/bin/env bash

declare -A get_cmd_for_prop

device=''
single_device=true

# if [ $# -eq 1 ]
# then

# else
#     device="$1"
# fi

get_cmd_for_prop=(
    [DEVICE_SERIAL_NUMBER]=ro.serialno
    [SIM_OPERATORS]=gsm.sim.operator.alpha
    [PROCESSOR_VARIANT]=dalvik.vm.isa.arm.variant
    [SIM_STATUS]=gsm.sim.state
    [TIME_ZONE]=persist.sys.timezone
    [SOFTWARE_BUILD_VERSION]=ro.build.software.version
    [SECURITY_PATCH]=ro.build.version.security_patch
    [SDK_VERSION]=ro.build.version.sdk
    [HARDWARE_COMPANY]=ro.hardware
    [PRODUCT_BOARD]=ro.product.board
    [PRODUCT_BRAND]=ro.product.brand
    [PRODUCT_DEVICE]=ro.product.device
    [PRODUCT_MANUFACTURER]=ro.product.manufacturer
    [PRODUCT_MODEL]=ro.product.model
    [PRODUCT_NAME]=ro.product.name
    )

# echo ${get_cmd_for_prop[DEVICE_SERIAL_NUMBER]}

for property in "${!get_cmd_for_prop[@]}"
do
	echo "$property - `adb shell getprop ${get_cmd_for_prop[$property]}`"
done

