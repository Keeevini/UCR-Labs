/*	Author: kni005
 *  Partner(s) Name: 
 *	Lab Section: 023
 *	Assignment: Lab 2  Exercise 3
 *	Exercise Description: [Parking space with full lot indicator]
 *
 *	I acknowledge all content contained herein, excluding template or example
 *	code, is my own original work.
 */
#include <avr/io.h>
#ifdef _SIMULATE_
#include "simAVRHeader.h"
#endif

int main(void) {
	/* Insert DDR and PORT initializations */
	DDRA = 0x00; PORTA = 0xFF; // Configure port A's 8 pins as inputs, initialize to 1s
	DDRB = 0xFF; PORTB = 0x00; // Configure port B's 8 pins as outputs, initialize to 0s
	DDRC = 0xFF; PORTC = 0x00; // Configure port C's 8 pins as outputs, initialize to 0s
	/* Insert your solution below */
	unsigned char tmpA = 0x00; // Temporary variable to hold the value of A
	while (1) {
		tmpA = PINA;
		int i = 0;
		unsigned char cntavail = 0x00; // Temporary variable to hold the number of empty spaces
		for (i = 0; i < 4; ++i) { // loop 4 times
			if ( (tmpA & 0x01) == 0x00) {
				++cntavail;	
			}
			tmpA = tmpA >> 1;
		}
		if (cntavail == 0) // If the parking lot is completely full
			cntavail = (cntavail & 0x7F) | 0x80; // Sets cntavail to 1bbbbbbbb (clear leftmost 1 bit, then set PC7 to 1)
		PORTC = cntavail;
	}
	return 0;
}
