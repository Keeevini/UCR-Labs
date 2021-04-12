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
	DDRC = 0xFF; PORTC = 0x00; // Configure port C's 8 pins as outputs, initialize to 0s

	// Should use a temporary variable for all bit manipulation
	unsigned char tmpA = 0x00; // Temporary variable to hold the value of A
	unsigned char tmpC = 0x00; // Temporary variable to hold the value of B
	
	/* Insert your solution below */
	while (1) {
		unsigned char mask = 0xDF;
		unsigned char a;
		tmpA = PINA;
		for (a = 0; a < 3; ++a) { // for level PC5 PC4 PC3
			if ( (tmpA == (a*2 + 1)) || (tmpA == (a*2 + 2)) ) {
				tmpC = (tmpC & mask) | (32/(a+1));
			}
			mask = mask + 16/(a+1);
		}
		for (a = 0; a < 3; ++a) { // for level PC2 PC 1 PC0
		}
		
		if (tmpA <= 4) // low fuel
			tmpC = (tmpC & 0xBF) | 0x40; // Sets tmpC to c1cccccc (clear 2nd to left bit, then set PC6 to 1)
		PORTC = tmpC;
	}
	return 0;
}