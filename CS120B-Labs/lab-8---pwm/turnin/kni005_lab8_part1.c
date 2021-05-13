/*	Author: kni005
 *  Partner(s) Name: 
 *	Lab Section: 021
 *	Assignment: Lab 8  Exercise 1
 *	Exercise Description: [CDE]
 *
 *	I acknowledge all content contained herein, excluding template or example
 *	code, is my own original work.
 *
 *	Demo Link: https://drive.google.com/file/d/1HCa0CWbQcbkNPkJorKTD0yZw5Fr_-Eqb/view?usp=sharing
 */
 
#include <avr/io.h>
#ifdef _SIMULATE_
#include "simAVRHeader.h"
#endif

unsigned char tmpInput = 0x00;

enum SM_States { START, IDLE, PRESSED, WAIT } SM_State;
enum Buttons { NONE, C, D, E } Button;

// 0.954 hz is lowest frequency possible with this function based on settings in PWM_on()
// Passing in 0 as the frequency will stop the speaker from generating sound
void set_PWM(double frequency) {
	static double current_frequency; 	// Keeps tracck of the currently set frequency		
										// Will only update the registers when the frequency changes,
										// otherwise allows music to play uninterrupted.
	
	if (frequency != current_frequency) {
		if (!frequency) {
			TCCR3B &= 0x08; // Stops timer/counter
		}
		else {
			TCCR3B |= 0x03; // Resumes/continues timer/counter
		}

		// Prevents OCR3A from overflowing, using prescaler 64
		// 0.954 is smallest sfrequency that will not result in underflow
		if (frequency < 0.954) {
			OCR3A = 0xFFFF;
		}
		
		// Prevents OCR3A from underflowing, using prescaler 64
		// 31250 i largest frequency that will not result in underflow
		else if (frequency > 31250) {
			OCR3A = 0x0000;
		}
		
		// Set OCR3A based on desired frequency
		else {
			OCR3A = (short)(8000000 / (128 * frequency)) - 1;
		}
		
		TCNT3 = 0; // Resets counter
		current_frequency = frequency; // Updates the current frequency
	}
}

void PWM_on() {
	TCCR3A = (1 << COM3A0);
		// COM3A0: Toggle PB3 on compare match between counter and OCR3A
	TCCR3B = (1 << WGM32) | (1 << CS31) | (1 << CS30);
		// WGM32: When counter (TCNT3) matches OCR3A, reset counter
		// CS31 & CS30: Set a prescaler of 64
	set_PWM(0);
}

void PWM_off() {
	TCCR3A = 0x00;
	TCCR3B = 0x00;
}

void tick() {
	switch(SM_State) { // Transitions
		case START:
			Button = NONE;
			SM_State = IDLE;
			break;
		case IDLE:
			if (tmpInput == 0x01 || tmpInput == 0x02 || tmpInput == 0x04)
				SM_State = PRESSED;
			else
				Button = NONE;
			break;
		case PRESSED:
			if (tmpInput == 0x00)
				SM_State = IDLE;
			else
				SM_State = WAIT;
			break;
		case WAIT:
			if (tmpInput == 0x00)
				SM_State = IDLE;
			break;
		default:
			SM_State = START;
			break;
	}
	
	switch(SM_State) { // Outputs
		case PRESSED:
			if (tmpInput == 0x01)
				Button = C;
			else if (tmpInput == 0x02)
				Button = D;
			else if (tmpInput == 0x04)
				Button = E;
			else
				Button = NONE;
		case WAIT:
			if (!(tmpInput == 0x01 || tmpInput == 0x02 || tmpInput == 0x04))
				Button = NONE;
		case IDLE:
			if (Button == C)
				set_PWM(261.63);
			else if (Button == D)
				set_PWM(293.66);
			else if (Button == E)
				set_PWM(329.63);
			else
				set_PWM(0);
		default:
			break;
	}
}

int main(void) {
	/* Insert DDR and PORT initializations */
	DDRA = 0x00; PORTA = 0xFF; // Configure port A's 8 pins as inputs, initialize to 1s
	DDRB = 0xFF; PORTB = 0x00; // Configure port B's 8 pins as outputs, initialize to 0s	
	
	/* Insert your solution below */
	PWM_on();
	SM_State = START;
	
	while (1) {
		tmpInput = ~PINA & 0x07;
		tick();
	}
	return 1;
}
