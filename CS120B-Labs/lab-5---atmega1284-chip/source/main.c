/*	Author: kni005
 *  Partner(s) Name: 
 *	Lab Section: 021
 *	Assignment: Lab 5  Exercise 3
 *	Exercise Description: [Festive Lights Display]
 *
 *	I acknowledge all content contained herein, excluding template or example
 *	code, is my own original work.
 */
#include <avr/io.h>
#ifdef _SIMULATE_
#include "simAVRHeader.h"
#endif

enum SM_States { START, IDLE, PRESSED, WAIT } SM_State;
enum Lights_States { ODD, EVEN, ALL } Lights_State;
unsigned char tmpInputs;
unsigned char tmpLights;

void tick() {

	switch (SM_State) { // Transitions
		case START: // Initializing state machine
			Lights_State = ODD;
			SM_State = IDLE; // Initial state
			break;
		case IDLE:
			if ( (tmpInputs & 0x01) == 1)
				SM_State = PRESSED;
			break;
		case PRESSED:
			if ( (tmpInputs & 0x01) == 0)
				SM_State = IDLE;
			else
				SM_State = WAIT;
			break;
		case WAIT:
			if ( (tmpInputs & 0x01) == 0)
				SM_State = IDLE;
			break;
		default:
			SM_State = START;
	}

	switch (SM_State) { // Outputs
		case PRESSED:
			if (Lights_State == ODD)
				Lights_State = EVEN;
			else if (Lights_State == EVEN)
				Lights_State = ALL;
			else if (Lights_State == ALL)
				Lights_State = ODD;
		case WAIT:
		case IDLE:
			if (Lights_State == ODD)
				tmpLights = 0x15;
			if (Lights_State == EVEN)
				tmpLights = 0x2A;
			if (Lights_State == ALL)
				tmpLights = 0x3F;
		default:
			break;
	}
}

int main(void) {
	/* Insert DDR and PORT initializations */
	DDRD = 0x00; PORTD = 0xFF; // Configure port A's 8 pins as inputs, initialize to 1s
	DDRA = 0xFF; PORTA = 0x00; // Configure port B's 8 pins as outputs, initialize to 0s	
	/* Insert your solution below */
	tmpLights = 0x00; // Temporary variable to hold the value of outputs
	tmpInputs = 0x00;
	SM_State = START;
	while (1) {
		tmpInputs = PINA;
		tick();
		PORTD = tmpLights;		
	}
	return 1;
}
