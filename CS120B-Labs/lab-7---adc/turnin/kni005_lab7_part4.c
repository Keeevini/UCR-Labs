/*	Author: kni005
 *  Partner(s) Name: 
 *	Lab Section: 021
 *	Assignment: Lab 7  Exercise 4
 *	Exercise Description: [Displaying Photoresistor]
 *
 *	I acknowledge all content contained herein, excluding template or example
 *	code, is my own original work.
 *
 *	Demo Link: https://drive.google.com/file/d/1qwKly_ifdSI1YcPzF4mE41pqHAzvIorK/view?usp=sharing
 */
 
#include <avr/io.h>
#ifdef _SIMULATE_
#include "simAVRHeader.h"
#endif

unsigned char tmpOutput = 0x00;

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
	
	unsigned short MAX = 255;

	while (1) {
		unsigned short x = ADC;
		// Value of ADC register is now stored in variable x
		tmpOutput = 0x00;
		
		if (x >= (MAX/8)*1)
			tmpOutput = tmpOutput | 0x01;
		if (x >= (MAX/8)*2)
			tmpOutput = tmpOutput | 0x02;
		if (x >= (MAX/8)*3)
			tmpOutput = tmpOutput | 0x04;
		if (x >= (MAX/8)*4)
			tmpOutput = tmpOutput | 0x08;
		if (x >= (MAX/8)*5)
			tmpOutput = tmpOutput | 0x10;
		if (x >= (MAX/8)*6)
			tmpOutput = tmpOutput | 0x20;
		if (x >= (MAX/8)*7)
			tmpOutput = tmpOutput | 0x40;
		if (x >= (MAX/8)*8)
			tmpOutput = tmpOutput | 0x80;
		
		PORTD = tmpOutput;
	}
	return 1;
}
