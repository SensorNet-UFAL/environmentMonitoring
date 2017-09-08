/* Micaz.h
 *
 * This header defines the packets
 * in which the nodes will send
 * data through the wirless network,
 * any app constants should be declared
 * here as well.
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

#ifndef MICAZ_H
#define MICAZ_H

enum {
    TIMER_PERIOD_MILLI = 1024,
	PERIODICITY_MULTIPLIER = 30,
    AM_MICAZMSG = 0xfc
};

typedef nx_struct micazMsg {
    nx_uint16_t nodeid;
	nx_uint16_t Voltage_data;
	nx_uint16_t Temp_data;
	nx_uint16_t Hum_data;
	nx_uint16_t VisLight_data;
	nx_uint16_t InfLight_data;
    nx_int16_t Intersema_data[2];
} MicazMsg;

#endif
