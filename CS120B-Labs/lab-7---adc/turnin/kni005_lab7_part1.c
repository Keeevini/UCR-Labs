/*	Author: kni005
 *  Partner(s) Name: 
 *	Lab Section: 021
 *	Assignment: Lab 7  Exercise 1
 *	Exercise Description: [ADC]
 *
 *	I acknowledge all content contained herein, excluding template or example
 *	code, is my own original work.
 *
 *	Demo Link: https://drive.google.com/file/d/1t7NVwI0070gLWejVdmq9q551dE-lGfDk/view?usp=sharing
 */
 
#include <avr/io.h>
#ifdef _SIMULATE_
#include "simAVRHeader.h"
#endif

unsigned char tmpOutput_1 = 0x00;
unsigned char tmpOutput_2 = 0x00;

void ADC_init() {
	ADCSRA |= (1 << ADEN) | (1 << ADSC) | (1 << ADATE);
	// ADEN: setting this bit enables analog-to-digital conversion
	// ADSC: setting this bit starts the first conversion
	// ADATE: setting this bit enables auto-triggering. Since we are
	// 			in Free Running Mode, a new conversion will trigger whenever
	//			the previous conversion completes
}

int main(void) {
	/* Insert DDR and PORT initializations */
	DDRB = 0x00; PORTB = 0xFF; // Configure port B's 8 pins as inputs, initialize to 1s
	DDRD = 0xFF; PORTD = 0x00; // Configure port D's 8 pins as outputs, initialize to 0s	
	DDRC = 0xFF; PORTC = 0x00; // Configure port C's 8 pins as outputs, initialize to 0s	
	
	/* Insert your solution below */
	ADC_init();

	while (1) {
		unsigned short x = ADC;
		// Value of ADC register is now stored in variable x
		
		tmpOutput_1 = (char) x;
		tmpOutput_2 = (char) (x >> 8);
		
		PORTD = tmpOutput_1;
		PORTC = tmpOutput_2;
	}
	return 1;
}
