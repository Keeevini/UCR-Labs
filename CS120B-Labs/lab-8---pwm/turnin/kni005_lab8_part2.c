/*	Author: kni005
 *  Partner(s) Name: 
 *	Lab Section: 021
 *	Assignment: Lab 8  Exercise 2
 *	Exercise Description: [Scale]
 *
 *	I acknowledge all content contained herein, excluding template or example
 *	code, is my own original work.
 *
 *	Demo Link: https://drive.google.com/file/d/1mmlxIJ2AiYvFoyxRAF92SyOHDaXjg9IW/view?usp=sharing
 */
 
#include <avr/io.h>
#ifdef _SIMULATE_
#include "simAVRHeader.h"
#endif

unsigned char tmpInput = 0x00;
unsigned char tmpInput2 = 0x00;
unsigned char note = 0x00;

enum SM_Toggles { START1, IDLE1, PRESSED1, WAIT1 } SM_Toggle;
enum Powers { ON, OFF } Power;
enum SM_Changes { START2, IDLE2, PRESSED2, WAIT2} SM_Change;

double notes[8] = {261.63, 293.66, 329.63, 349.23, 392.00, 440.00, 493.88, 523.25};

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

void tick1() {
	tmpInput2 = tmpInput & 0x01;
	
	switch(SM_Toggle) { // Transitions
		case START1:
			Power = OFF;
			SM_Toggle = IDLE1;
			break;
		case IDLE1:
			if (tmpInput2 == 0x01)
				SM_Toggle = PRESSED1;
			break;
		case PRESSED1:
			if (tmpInput2 == 0x00)
				SM_Toggle = IDLE1;
			else
				SM_Toggle = WAIT1;
			break;
		case WAIT1:
			if (tmpInput2 == 0x00)
				SM_Toggle = IDLE1;
			break;
		default:
			SM_Toggle = START1;
	}
	
	switch(SM_Toggle) { // Outputs
		case PRESSED1:
			if (Power == ON)
				Power = OFF;
			else
				Power = ON;
			break;
		case WAIT1:
		case IDLE1:
		default:
			break;
	}
}

void tick2() {
	tmpInput2 = tmpInput & 0x06;
	
	switch(SM_Change) { // Transitions
		case START2:
			note = 0;
			SM_Change = IDLE2;
			break;
		case IDLE2:
			if (tmpInput2 == 0x02 || tmpInput2 == 0x04)
				SM_Change = PRESSED2;
			break;
		case PRESSED2:
			if (tmpInput2 == 0x00)
				SM_Change = IDLE2;
			else
				SM_Change = WAIT2;
			break;
		case WAIT2:
			if (tmpInput2 == 0x00)
				SM_Change = IDLE2;
			break;
		default:
			SM_Change = START2;
	}
	
	switch(SM_Change) { // Outputs
		case PRESSED2:
			if (Power == ON) {
				if (tmpInput2 == 0x02)
					if (note < 7)
						++note;
				if (tmpInput2 == 0x04)
					if (note > 0)
						--note;
			}
		case WAIT2:
		case IDLE2:
			if (Power == ON)
				set_PWM(notes[note]);
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
	SM_Toggle = START1;
	SM_Change = START2;
	
	while (1) {
		tmpInput = ~PINA & 0x07;
		tick1();
		tick2();
	}
	return 1;
}
