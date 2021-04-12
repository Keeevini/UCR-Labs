/*	Author: kni005
 *  Partner(s) Name: 
 *	Lab Section:
 *	Assignment: Lab 3  Exercise 5
 *	Exercise Description: [Passenger Airbag]
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
	DDRB = 0x01; PORTB = 0x01; // Configure port B's 1 pin as inputs, initialize to 1s
	DDRB = 0xFE; PORTB = 0x01; // Configure port B's 7 pins as outputs, initialize to 0s
	DDRD = 0x00; PORTA = 0xFF; // Configure port D's 8 pins as inputs, initialize to 1s

	// Should use a temporary variable for all bit manipulation
	unsigned char tmpB = 0x00; // Temporary variable to hold the value of B
	unsigned char tmpD = 0x00; // Temporary variable to hold the value of D


	/* Insert your solution below */
	while (1) {
		tmpD = PIND;
		tmpB = PINB;
		if (tmpD >= 0x23)
			PORTB = (PORTB & 0xFD) | 0x02; // Sets PORTB to bbbbbb1b (clear 2nd to right of B, then set to 1)
		if (tmpD < 0x23 && tmpB > 0x05)
			PORTB = (PORTB & 0xFB) | 0x04; // Setes PORTB to bbbbb1bb (clear 3rd to right of B, then set to 1)
	}
	return 0;
}
