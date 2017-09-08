/* SenseAppC.nc
 *
 * Components should be wired here
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

#include "Micaz.h"
#include <Timer.h>

configuration SenseAppC {

}

implementation {
    components MainC, LedsC, SenseC as App;
    components ActiveMessageC as AM;
    components new TimerMilliC() as Timer;
    components CollectionC;
    components new CollectionSenderC(AM_MICAZMSG) as Sender;
    /*components new Accel202C();*/
	components new Intersema5534C();
	components new SensirionSht11C();
	components new Taos2550C();
	components new DemoSensorC() as Voltage;
	components DelugeC;

	DelugeC.Leds -> LedsC;
    App.Control -> AM;
    App.Leds -> LedsC;
    App.Boot -> MainC;
    App.CollectionControl -> CollectionC;
    App.Send -> Sender;
    App.Timer -> Timer;
    App.Voltage -> Voltage;
    App.Temperature -> SensirionSht11C.Temperature;
    /*App.X_Axis -> Accel202C.X_Axis;*/
    /*App.Y_Axis -> Accel202C.Y_Axis;*/
	App.Intersema -> Intersema5534C.Intersema;
	App.Humidity -> SensirionSht11C.Humidity;
	App.VisibleLight -> Taos2550C.VisibleLight;
	App.InfraredLight -> Taos2550C.InfraredLight;
}
