SRCREV = "648ffc470824c43eb0d16c485f4c24816b32cd6f"

do_deploy_append() {

    echo "" >> ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
    echo "## enable_uart" >> ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
    echo "##     New firmware parameter" >> ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
    echo "##     RPi3 won't boot without this or disabling of BT" >> ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
    echo "enable_uart=1" >> ${DEPLOYDIR}/bcm2835-bootfiles/config.txt

    if [ -n "${ENABLE_RPI3_SERIAL_CONSOLE}" ]; then
        echo "" >> ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
        echo "## Disable RPi3 bluetooth to enable serial console on UART0" >> ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
        echo "dtoverlay=pi3-disable-bt-overlay.dtb" >> ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
    fi

    if [ -n "${MAX_USB_CURRENT}" ]; then
        sed -i 's/#max_usb_current=0/max_usb_current=1/g' ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
    fi

    if [ -n "${AVOID_PWM_PLL}" ]; then
        sed -i 's/#avoid_pwm_pll=1/avoid_pwm_pll=1/g' ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
    fi

    if [ -n "${DISABLE_CAMERA_LED}" ]; then
        sed -i 's/#disable_camera_led=1/disable_camera_led=1/g' ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
    fi

    if [ "${RPI_VER_3}" -eq "1" ]; then
        sed -i 's/arm_freq=1000/arm_freq=1200/g' ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
        sed -i 's/over_voltage=2/over_voltage=0/g' ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
    fi
}
