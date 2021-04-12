/*	Author: kni005
 *  Partner(s) Name: 
 *	Lab Section:
 *	Assignment: Lab 3  Exercise 4
 *	Exercise Description: [Mapping nibbles]
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

	// Should use a temporary variable for all bit manipulation
	unsigned char tmp1 = 0x00; // Temporary variable to hold the value of upper nibble of A
	unsigned char tmp2 = 0x00; // Temporary variable to hold the value of lower nibble of A

	/* Insert your solution below */
	while (1) {
		tmp1 = (PINA & 0xF0) >> 4;
		tmp2 = (PINA & 0x0F) << 4;
		PORTB = (PORTB & 0xF0) | tmp1; // Sets PORTB to bbbb1111 (clear lower nibble of B, then set tmp1 to B)
		PORTC = (PORTC & 0x0F) | tmp2; // Sets PORTC to 2222cccc (clear upper nibble of C, then set tmp2 to C)
	}
	return 0;
}
