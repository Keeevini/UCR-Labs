/*	Author: kni005
 *  Partner(s) Name: 
 *	Lab Section:
 *	Assignment: Lab #  Exercise #
 *	Exercise Description: [optional - include for your own benefit]
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
	DDRB = 0x00; PORTB = 0xFF; // Configure port B's 8 pins as inputs, initialize to 1s
	DDRC = 0xFF; PORTC = 0x00; // Configure port C's 8 pins as outputs, initialize to 0s

	// Should use a temporary variable for all bit manipulation
	unsigned char tmpA = 0x00; // Temporary variable to hold the value of A
	unsigned char tmpB = 0x00; // Temporary variable to hold the value of B
	
	/* Insert your solution below */
	while (1) {
		unsigned char counter = 0x00; // Temporary variable to hold the number of 1s
		unsigned char a;
		tmpA = PINA;
		tmpB = PINB;
		for (a = 0; a < 8; ++a) { // Loop through each pin
			if ( (tmpA & 0x01) == 0x01)
				++counter;
			if ( (tmpB & 0x01) == 0x01)
				++counter;
			tmpA = tmpA >> 1;				
			tmpB = tmpB >> 1;
		}
		PORTC = counter;
	}
	return 0;
}
