/*	Author: kni005
 *  Partner(s) Name: 
 *	Lab Section:
 *	Assignment: Lab 3  Exercise 3
 *	Exercise Description: [Seatbelt light]
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
		tmpA = PINA & 0x0F;
		tmpC = 0x40;
		if (tmpA > 0)
			tmpC = tmpC | 0x20;
		if (tmpA > 2)
			tmpC = tmpC | 0x10;
		if (tmpA > 4)
			tmpC = tmpC | 0x08;
		if (tmpA > 6)
			tmpC = tmpC | 0x04;
		if (tmpA > 9)
			tmpC = tmpC | 0x02;
		if (tmpA > 12)
			tmpC = tmpC | 0x01;
		if (tmpA >= 5) // not low fuel
			tmpC = tmpC & 0xBF;

		tmpA = PINA & 0x70;
		if (tmpA == 0x30) // Seatbelt light
			tmpC = (tmpC & 0x7F) | 0x80;
		PORTC = tmpC;
	}
	return 0;
}
