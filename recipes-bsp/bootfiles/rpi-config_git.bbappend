SRCREV = "648ffc470824c43eb0d16c485f4c24816b32cd6f"

do_deploy_append() {
    #!/bin/sh
    if [ "${MACHINE}" = "raspberrypi2" ]; then
        if [ -n "${RPI_2_ARM_FREQ}" ]; then
            sed -i '/#arm_freq/ c\arm_freq=${RPI_2_ARM_FREQ}' ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
        fi

        if [ -n "${RPI_2_CORE_FREQ}" ]; then
            sed -i '/#core_freq/ c\core_freq=${RPI_2_CORE_FREQ}' ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
        fi

        if [ -n "${RPI_2_SDRAM_FREQ}" ]; then
            sed -i '/#sdram_freq/ c\sdram_freq=${RPI_2_SDRAM_FREQ}' ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
        fi

        if [ -n "${RPI_2_OVER_VOLTAGE}" ]; then
            sed -i '/#over_voltage/ c\over_voltage=${RPI_2_OVER_VOLTAGE}' ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
        fi
    fi

    if [ "${MACHINE}" = "raspberrypi3" ]; then
        if [ -n "${RPI_3_ARM_FREQ}" ]; then
            sed -i '/#arm_freq/ c\arm_freq=${RPI_3_ARM_FREQ}' ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
        fi

        if [ -n "${RPI_3_CORE_FREQ}" ]; then
            sed -i '/#core_freq/ c\core_freq=${RPI_3_CORE_FREQ}' ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
        fi

        if [ -n "${RPI_3_SDRAM_FREQ}" ]; then
            sed -i '/#sdram_freq/ c\sdram_freq=${RPI_3_SDRAM_FREQ}' ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
        fi

        if [ -n "${RPI_3_OVER_VOLTAGE}" ]; then
            sed -i '/#over_voltage/ c\over_voltage=${RPI_3_OVER_VOLTAGE}' ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
        fi

        if [ -n "${ENABLE_RPI3_SERIAL_CONSOLE}" ]; then
            echo "" >> ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
            echo "## Disable RPi3 bluetooth to enable serial console on UART0" >> ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
            echo "dtoverlay=pi3-disable-bt-overlay.dtb" >> ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
        fi
    fi

    if [ -n "${MAX_USB_CURRENT}" ]; then
        sed -i '/#max_usb_current/ c\max_usb_current=${MAX_USB_CURRENT}' ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
    fi

    if [ -n "${AVOID_PWM_PLL}" ]; then
        sed -i '/#avoid_pwm_pll/ c\avoid_pwm_pll=${AVOID_PWM_PLL}' ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
    fi

    if [ -n "${DISABLE_CAMERA_LED}" ]; then
        sed -i '/#disable_camera_led/ c\disable_camera_led=${DISABLE_CAMERA_LED}' ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
    fi
}
