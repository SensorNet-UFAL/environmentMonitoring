/*SenseBaseAppC.nc
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

configuration SenseBaseAppC {}

implementation {
    components MainC, LedsC, SenseBaseC as App;
    components ActiveMessageC as AM;
    components SerialActiveMessageC as SerialAM;
    components new TimerMilliC() as Timer;
    components CollectionC;
	components DelugeC;

    App.RadioControl -> AM;
    App.SerialControl -> SerialAM;
    App.CollectionControl -> CollectionC;
    App.RootControl -> CollectionC;
    App.Leds -> LedsC;
    App.Boot -> MainC;
    App.AMSend -> SerialAM.AMSend[AM_MICAZMSG];
    App.Receive -> CollectionC.Receive[AM_MICAZMSG];
    App.Packet -> SerialAM;
}
