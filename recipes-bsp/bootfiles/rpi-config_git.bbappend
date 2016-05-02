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

    if [-n "${MAX_USB_CURRNET}" ]; then
        echo "" >> ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
        echo "## avoid limiting usb current" >> ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
        echo "max_usb_current=0" >> ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
    fi

    if [-n "${AVOID_PWM_PLL}" ]; then
        echo "" >> ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
        echo "## don't dedicate a pll to PWM audio" >> ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
        echo "avoid_pwm_pll=1" >> ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
    fi

    if [-n "${DISABLE_CAMERA_LED}" ]; then
        echo "" >> ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
        echo "## disable camera LED" >> ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
        echo "disable_camera_led=1" >> ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
    fi
}
