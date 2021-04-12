/*	Author: kni005
 *  Partner(s) Name: 
 *	Lab Section: 023
 *	Assignment: Lab 2  Exercise 1
 *	Exercise Description: [Garage door light sensor]
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

	/* Insert your solution below */
	// unsigned char tmpB = 0x00; // Temporary variable to hold the value of B
	// unsigned char tmpA = 0x00; // Temporary variable to hold the value of A
	while (1) {
		if( (PINA & 0x03) == 0x01) { // True if PA0 = 1 && PA1 = 0
			PORTB = (PORTB & 0xFC) | 0x01; // Sets PORTB to bbbbbb01 (clear rightmost 2 bits, then set to 01)
		}
		else {
			PORTB = (PORTB & 0xFC) | 0x00; // Sets PORTB to bbbbbb00 (clear rightmost 2 bits, then set to 00)
		}
	}
	return 0;
}
