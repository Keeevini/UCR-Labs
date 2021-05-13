/*	Author: kni005
 *  Partner(s) Name: 
 *	Lab Section: 021
 *	Assignment: Lab 8  Exercise 3
 *	Exercise Description: [Melody]
 *
 *	I acknowledge all content contained herein, excluding template or example
 *	code, is my own original work.
 *
 *	Demo Link: https://drive.google.com/file/d/1W4DO2U92RisSnRdjqGxAIKl0E4G7xfqg/view?usp=sharing
 */
 
#include <avr/io.h>
#include <avr/interrupt.h>
#ifdef _SIMULATE_
#include "simAVRHeader.h"
#endif

unsigned char tmpInput = 0x00;
unsigned char note = 0x00;

enum SM_States { START, OFF, ON, WAIT } SM_State;
double notes[29] = {329.63, 293.66, 261.63, 293.66, 329.63, 329.63, 329.63, 329.63, 293.66, 293.66, 293.66, 293.66, 329.63, 392.00, 392.00, 392.00,
					329.63, 293.66, 261.63, 293.66, 329.63, 329.63, 329.63, 329.63, 293.66, 293.66, 329.63, 293.66, 329.63};

volatile unsigned char TimerFlag = 0; // TimerISR() sets this to 1. C programmer should clear to 0

// Internal variables for mapping AVR's ISR to our cleaner TimerISR model.

unsigned long _avr_timer_M = 1; // Start count from here, down to 0. Default 1 ms
unsigned long _avr_timer_cntcurr = 0; // Current internal count of 1ms ticks

void TimerOn() {
	// AVR timer/counter controller register TCCR1
	TCCR1B = 0x0B; 	// bit3 = 0: CTC mode (clear timer on compare)
					// bit2bit1bit0=011: pre-scaler /64
					// 00001011: 0x0B
					// So, 8 MHz clock or 8,000,000 /64 = 125,000 ticks/s
					// Thus, TCNT1 register will count at 125,000 tick/s
					
	// AVR output compare register OCR1A
	OCR1A = 125;	// Timer interrupt will be generated when TCNT1==OCR1A
					// We want a 1ms tick. 0.001 s * 125,000 tick/s - 125
					// So when TCNT1 register equals 125,
					// 1 ms has passed. Thus, we compare to 125.
	// AVR timer interrupt mask register
	TIMSK1 = 0x02;	// bit1: OCIE1A -- enables compare match interrupt
	
	// Initialize avr counter
	TCNT1 = 0;
	
	_avr_timer_cntcurr = _avr_timer_M;
	// TimerISR will be called every _avr_timer_cntcurr milliseconds
	
	// Enable global interrupts
	SREG |= 0x80; // 0x80: 1000000
}

// The "enable global interrupts" line is SREG |= 0x80, not SREG |= 0x80;

void TimerOff() {
	TCCR1B = 0x00; // bit3bit1bit0=000: timer off
}

void TimerISR() {
	TimerFlag = 1;
}

// In our approach, the C programmer does not touch this ISR, but rather TimerISR()
ISR(TIMER1_COMPA_vect) {
	// CPU automatically calls when TCNT1 == OCR1 (every 1 ms per TimerOn settings)
	_avr_timer_cntcurr--; // Count down to 0 rather than up to TOP
	if (_avr_timer_cntcurr == 0) { // results in a more efficient compare
		TimerISR(); // Call the ISR that the user uses
		_avr_timer_cntcurr = _avr_timer_M;
	}
}

// set TimerISR() to tick ever M ms
void TimerSet(unsigned long M) {
	_avr_timer_M = M;
	_avr_timer_cntcurr = _avr_timer_M;
}

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
			note = 0x00;
			SM_State = OFF;
			break;
		case OFF:
			if (tmpInput == 0x01)
				SM_State = ON;
			note = 0x00;
			break;
		case ON:
			if (tmpInput == 0x01 && note >= 0x1D)
				SM_State = WAIT;
			else if (note == 0x1D)
				SM_State = OFF;
			break;
		case WAIT:
			if (tmpInput == 0x00)
				SM_State = OFF;
			break;
		default:
			SM_State = START;
	}
	
	switch(SM_State) { // Outputs
		case ON:
			set_PWM(notes[note]);
			++note;
			break;
		case WAIT:
		case OFF:
			set_PWM(0);
			break;
		default:
			break;
	}
}

int main(void) {
	/* Insert DDR and PORT initializations */
	DDRA = 0x00; PORTA = 0xFF; // Configure port A's 8 pins as inputs, initialize to 1s
	DDRB = 0xFF; PORTB = 0x00; // Configure port B's 8 pins as outputs, initialize to 0s	
	
	/* Insert your solution below */
	TimerSet(250);
	TimerOn();
	
	PWM_on();
	SM_State = START;
	
	while (1) {
		tmpInput = ~PINA & 0x01;
		tick();
		
		while (!TimerFlag); // Wait 1 sec
		TimerFlag = 0;
	}
	return 1;
}
