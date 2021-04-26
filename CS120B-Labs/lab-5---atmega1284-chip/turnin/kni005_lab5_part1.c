/*	Author: kni005
 *  Partner(s) Name: 
 *	Lab Section:
 *	Assignment: Lab 5  Exercise 1
 *	Exercise Description: [Fuel light level]
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
		unsigned char maskInc = 16;
		unsigned char bitMover = 32;
		unsigned char a;
		tmpA = ~PINA;
		tmpC = 0x00;
		for (a = 0; a < 3; ++a) { // for level PC5 PC4 PC3
			if ( ((tmpA & 0x0F) >= (a*2 + 1)) /* && ((tmpA & 0x0F) <= (a*2 + 2))*/ ) {
				tmpC = (tmpC & mask) | (bitMover);
			}
			mask = mask + maskInc;
			maskInc = maskInc / 2;
			bitMover = bitMover / 2;
		}
		for (a = 0; a < 3; ++a) { // for level PC2 PC 1 PC0
			if ( ((tmpA & 0x0F) >= (a*3 + 7)) /* && ((tmpA & 0x0F) <= (a*3 + 9))*/ ) {
				tmpC = (tmpC & mask) | (bitMover);
			}
			mask = mask + maskInc;
			maskInc = maskInc / 2;
			bitMover = bitMover / 2;
		}
		if ((tmpA & 0x0F) <= 0x04) // low fuel
			tmpC = (tmpC & 0xBF) | 0x40; // Sets tmpC to c1cccccc (clear 2nd to left bit, then set PC6 to 1)
		PORTC = tmpC;
	}
	return 0;
}
