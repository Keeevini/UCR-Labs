/*	Author: kni005
 *  Partner(s) Name: 
 *	Lab Section: 023
 *	Assignment: Lab 2  Exercise 4
 *	Exercise Description: [Amusement Park Ride Weights]
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
	DDRC = 0x00; PORTC = 0xFF; // Configure port C's 8 pins as inputs, initialize to 1s
	DDRD = 0xFF; PORTD = 0x00; // Configure port D's 8 pins as outputs, initialize to 0s

	/* Insert your solution below */
	unsigned char tmpA = 0x00; // Temporary variable to hold the value of A
	unsigned char tmpB = 0x00; // Temporary variable to hold the value of B
	unsigned char tmpC = 0x00; // Temporary variable to hold the value of C
	while (1) {
		tmpA = PINA;
		tmpB = PINB;
		tmpC = PINC;

		if ( (tmpA + tmpB + tmpC) > 140)
			PORTD = (PORTD & 0xFE) | 0x01; // Sets PORTD to ddddddd1 (clear right most bit, then set to 1)
		if ( ((tmpA - tmpC) > 80) || ((tmpC - tmpA) > 80) )
			PORTD = (PORTD & 0xFD) | 0x2; // Sets PORTD to dddddd1d (clear 2nd from right, then set to 1)
		
		PORTD = (PORTD & 0x03) | ((tmpA + tmpB + tmpC) << 2); // Sets PORTD to aaaaaadd (clears 6 left bits, then sets them to average)
	}
	return 0;
}
