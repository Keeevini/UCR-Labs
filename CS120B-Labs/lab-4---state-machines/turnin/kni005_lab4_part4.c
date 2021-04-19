/*	Author: kni005
 *  Partner(s) Name: 
 *	Lab Section: 021
 *	Assignment: Lab 4  Exercise 4
 *	Exercise Description: [Keypad Unlocking/Locking]
 *
 *	I acknowledge all content contained herein, excluding template or example
 *	code, is my own original work.
 */
#include <avr/io.h>
#ifdef _SIMULATE_
#include "simAVRHeader.h"
#endif

enum SM_States { START, IDLE, POUND, Y, X, INSIDE, WAIT } SM_State;
enum Keypad_States { LOCKED, ENTRY, UNLOCKED, EXIT } Keypad_State;
unsigned char tmpB;
unsigned char tmpA;

void tick() {

	switch (SM_State) { // Transitions
		case START: // Initializing state machine
			tmpB = 0x00;
			Keypad_State = LOCKED;
			SM_State = IDLE; // Initial state
			break;
		case IDLE:
			if ( (tmpA & 0x07) == 4)
				SM_State = POUND;
			else if ( (tmpA & 0x07) == 2)
				SM_State = Y;
			else if ( (tmpA & 0x07) == 1)
				SM_State = X;
			else if ( (tmpA & 0x80) == 0x80)
				SM_State = INSIDE;
			else if ( ((tmpA & 0x07) >= 1) || ((tmpA & 0x80) == 0x80) )
				SM_State = WAIT;
			break;
		
		case POUND:
			if ( (tmpA & 0x07) == 0)
				SM_State = IDLE;
			else
				SM_State = WAIT;
			break;
		case Y:
			if ( (tmpA & 0x07) == 0)
				SM_State = IDLE;
			else
				SM_State = WAIT;
			break;
		case X:
			if ( (tmpA & 0x07) == 0)
				SM_State = IDLE;
			else
				SM_State = WAIT;
			break;
		case INSIDE:
			if ( (tmpA & 0x07) == 0)
				SM_State = IDLE;
			else
				SM_State = WAIT;
			break;
		case WAIT:
			if ( ((tmpA & 0x07) == 0) && ((tmpA & 0x80) == 0x00) )
				SM_State = IDLE;
			break;
		default:
			SM_State = START;
	}

	switch (SM_State) { // Outputs
		case IDLE:
			break;
		case POUND:
			if (Keypad_State == LOCKED)
				Keypad_State = ENTRY;
			if (Keypad_State == UNLOCKED)
				Keypad_State = EXIT;
			break;
		case Y:
			if (Keypad_State == ENTRY) {
				Keypad_State = UNLOCKED;
				tmpB = 0x01;
			}
			if (Keypad_State == EXIT) {
				Keypad_State = LOCKED;
				tmpB = 0x00;
			}
			break;
		case X:
			if ( (Keypad_State == ENTRY) || (Keypad_State == EXIT) )
				Keypad_State = LOCKED;
			break;
		case INSIDE:
			if (Keypad_State == UNLOCKED) {
				Keypad_State = LOCKED;
				tmpB = 0x00;
			}
			if (Keypad_State == ENTRY)
				Keypad_State = LOCKED;
			break;
		case WAIT:
		default:
			break;
	}
}

int main(void) {
	/* Insert DDR and PORT initializations */
	DDRA = 0x00; PORTA = 0xFF; // Configure port A's 8 pins as inputs, initialize to 1s
	DDRB = 0xFF; PORTC = 0x00; // Configure port B's 8 pins as outputs, initialize to 0s	
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
