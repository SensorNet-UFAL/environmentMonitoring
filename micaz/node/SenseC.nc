/* SenseC.nc
 *
 * implementation of the sensor nodes.
 * We're collecting data from pressure
 * temperature, light, humidity and node voltage
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


//SenseC.nc
#include "Micaz.h"
#include <string.h>
#include <Timer.h>

module SenseC {
	uses { //Declaring used interfaces
		interface Boot;
		interface SplitControl as Control;
		interface StdControl as CollectionControl;
		interface Send;
		interface Leds;
		interface Timer<TMilli>;
		interface Intersema;
		interface Read<uint16_t> as Temperature;
		interface Read<uint16_t> as Humidity;
		interface Read<uint16_t> as Voltage;
		interface Read<uint8_t> as VisibleLight;
		interface Read<uint8_t> as InfraredLight;
	}
}

implementation {
	message_t message;
	bool busy = FALSE;
	uint8_t clockCounter = 1;
	uint16_t temp, hum, visLight, infLight, voltage;
	int16_t intersema[2];

	event void Boot.booted() {
        call Control.start();
    }

    event void Control.startDone(error_t err) {
        if (err == SUCCESS) {
            call Timer.startPeriodic(TIMER_PERIOD_MILLI);
            call CollectionControl.start();
            call Leds.led0On();
        } else
            call Control.start();
    }

    event void Control.stopDone(error_t err) {/* NOT IMPLEMENTED */}

	task void sendPacket() {
		MicazMsg* packet = (MicazMsg*)(call Send.getPayload(&message, sizeof(MicazMsg)));
		packet->nodeid = TOS_NODE_ID;
		packet->Voltage_data = voltage;
		packet->Intersema_data[0] = intersema[0];
		packet->Intersema_data[1] = intersema[1];
		packet->Temp_data = temp;
		packet->Hum_data = hum;
		packet->VisLight_data = visLight;
		packet->InfLight_data = infLight;

		if(!busy) {
			if (call Send.send(&message, sizeof(MicazMsg)) == SUCCESS) {
				busy = TRUE;
				call Leds.led2On();
			}
		}
	}

    event void Timer.fired() {
		if(clockCounter >= PERIODICITY_MULTIPLIER) {
			clockCounter = 1;
			call Voltage.read();
			call Intersema.read();
			call Temperature.read();
			call Humidity.read();
			call VisibleLight.read();
			call InfraredLight.read();
		}
		else {
			clockCounter++;
		}
    }

    event void Voltage.readDone(error_t err, uint16_t data) {
    	voltage = data;
    }

	event void Intersema.readDone(error_t err, int16_t* data){
		intersema[0] = data[0];
		intersema[1] = data[1];
		post sendPacket();
	}

	event void Temperature.readDone(error_t err, uint16_t data){
		temp = data;
	}

	event void Humidity.readDone(error_t err, uint16_t data){
		hum = data;
	}

	event void VisibleLight.readDone(error_t err, uint8_t data){
		visLight = data;
	}

	event void InfraredLight.readDone(error_t err, uint8_t data){
		infLight = data;
	}

    event void Send.sendDone(message_t* bufPtr, error_t error) {
        if (error == SUCCESS) {
            busy = FALSE;
			call Leds.led2Off();
        }
  	}
}
