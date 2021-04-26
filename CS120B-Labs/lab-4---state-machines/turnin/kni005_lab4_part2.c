/*	Author: kni005
 *  Partner(s) Name: 
 *	Lab Section: 021
 *	Assignment: Lab 4  Exercise 2
 *	Exercise Description: [Incrementing/Decrementing PORTC]
 *
 *	I acknowledge all content contained herein, excluding template or example
 *	code, is my own original work.
 */
#include <avr/io.h>
#ifdef _SIMULATE_
#include "simAVRHeader.h"
#endif

enum SM_States { START, IDLE, PRESSED, DOUBLE, WAIT } SM_State;
unsigned char tmpC;
unsigned char tmpA;

void tick() {

	switch (SM_State) { // Transitions
		case START: // Initializing state machine
			tmpC = 0x07;
			SM_State = IDLE; // Initial state
			break;
		case IDLE:
			if ( (tmpA & 0x03) >= 1)
				SM_State = PRESSED;
			break;
		case PRESSED:
			if ( (tmpA & 0x03) == 0)
				SM_State = IDLE;
			if ( (tmpA & 0x03) == 1 || (tmpA & 0x03) == 2 )
				SM_State = WAIT;
			if ( (tmpA & 0x03) == 3)
				SM_State = DOUBLE;
			break;
		case DOUBLE:
			if ( (tmpA & 0x03) == 0)
				SM_State = IDLE;
			else
				SM_State = WAIT;
			break;
		case WAIT:
			if ( (tmpA & 0x03) == 3)
				SM_State = DOUBLE;
			if ( (tmpA & 0x03) == 0)
				SM_State = IDLE;
			break;
		default:
			SM_State = START;
	}

	switch (SM_State) { // Outputs
		case IDLE:
			break;
		case PRESSED:
			if ( (tmpA & 0x03) == 0x01) {
				if (tmpC <= 8)
					tmpC = tmpC + 0x01;
			}
			if ( (tmpA & 0x03) == 0x02) {
				if (tmpC >= 1)
					tmpC = tmpC - 0x01;
			}
			break;
		case DOUBLE:
			tmpC = 0x00;
		case WAIT:
		default:
			break;
	}
}

int main(void) {
	/* Insert DDR and PORT initializations */
	DDRA = 0x00; PORTA = 0xFF; // Configure port A's 8 pins as inputs, initialize to 1s
	DDRC = 0xFF; PORTC = 0x00; // Configure port C's 8 pins as outputs, initialize to 0s	
	/* Insert your solution below */
	tmpC = 0x00; // Temporary variable to hold the value of C
	SM_State = START;
	while (1) {
		tmpA = PINA;
		tick();
		PORTC = tmpC;		
	}
	return 1;
}
