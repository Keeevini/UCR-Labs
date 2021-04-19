/*	Author: kni005
 *  Partner(s) Name: 
 *	Lab Section: 021
 *	Assignment: Lab 4  Exercise 1
 *	Exercise Description: [Switching LEDs]
 *
 *	I acknowledge all content contained herein, excluding template or example
 *	code, is my own original work.
 */
#include <avr/io.h>
#ifdef _SIMULATE_
#include "simAVRHeader.h"
#endif

enum SM_States { START, IDLE, PRESSED, WAIT } SM_State;
unsigned char tmpB;
unsigned char tmpA;

void tick() {

	switch (SM_State) { // Transitions
		case START: // Initializing state machine
			tmpB = 0x01;
			SM_State = IDLE; // Initial state
			break;
		case IDLE:
			if ( (tmpA & 0x01) == 1)
				SM_State = PRESSED;
			break;
		case PRESSED:
			if ( (tmpA & 0x01) == 0)
				SM_State = IDLE;
			if ( (tmpA & 0x01) == 1)
				SM_State = WAIT;
			break;
		case WAIT:
			if ( (tmpA & 0x01) == 0)
				SM_State = IDLE;
			break;
		default:
			SM_State = START;
	}

	switch (SM_State) { // Outputs
		case IDLE:
			break;
		case PRESSED:
			if ( (tmpB & 0x03) == 0x01) {
				tmpB = 0x02;
			}
			else {
				tmpB = 0x01;
			}
			break;
		case WAIT:
		default:
			break;
	}
}

int main(void) {
	/* Insert DDR and PORT initializations */
	DDRA = 0x00; PORTA = 0xFF; // Configure port A's 8 pins as inputs, initialize to 1s
	DDRB = 0xFF; PORTB = 0x00; // Configre port B's 8 pins as outputs, initialize to 0s
	
	/* Insert your solution below */
	tmpB = 0x00; // Temporary variable to hold the value of B
	SM_State = START;
	while (1) {
		tmpA = PINA;
		tick();
		PORTB = tmpB;		
	}
	return 1;
}
