/* SenseBaseC.nc
 *
 * A header definition for micaz sensors
 *
 * @author: Geymerson Ramos
 * @email: geymerson@laccan.ufal.br
 * Last-Updated:
 *           By: Geymerson Ramos
 *     Update #: 2017
 */

/* Change Log:
 *
 */

#include "../node/Micaz.h"

module SenseBaseC {
    uses {
        interface SplitControl as SerialControl;
        interface SplitControl as RadioControl;
        interface StdControl as CollectionControl;
        interface RootControl;
        interface Leds;
        interface Boot;
        interface AMSend;
        interface Receive;
        interface Packet;
    }
}

implementation {
    bool busy = FALSE;
    message_t msg;
    MicazMsg* packet;

    event void Boot.booted() {
        call RadioControl.start();
    }

    event void RadioControl.startDone(error_t err) {
        if (err == SUCCESS) {
            call SerialControl.start();
        } else
            call RadioControl.start();
    }

    event void RadioControl.stopDone(error_t err) {/* NOT IMPLEMENTED */}

    event void SerialControl.startDone(error_t err) {
        if (err == SUCCESS){
        	call CollectionControl.start();
            call RootControl.setRoot();
            call Leds.led0On();
        }
        else
            call SerialControl.start();
    }

    event void SerialControl.stopDone(error_t err) {/* NOT IMPLEMENTED */}

    event message_t* Receive.receive(message_t *bufmsg, void *payload, uint8_t len) {
        MicazMsg* newpkt = (MicazMsg*) payload;
        if (len == sizeof(MicazMsg) && !busy) {
			call Leds.led1On();
            packet = (MicazMsg*) call Packet.getPayload(&msg, sizeof(MicazMsg));
            *packet = *newpkt;
            if (call AMSend.send(AM_BROADCAST_ADDR, &msg, sizeof(MicazMsg)) == SUCCESS) {
                busy = TRUE;
				call Leds.led2On();
			}
        }
        return bufmsg;
    }

    event void AMSend.sendDone(message_t* bufPtr, error_t error) {
        if (error == SUCCESS) {
            busy = FALSE;
			call Leds.led2Off();
			call Leds.led1Off();
        }
	}
}
