/*	Author: kni005
 *  	Partner(s) Name: 
 *	Lab Section: 021
 *	Assignment: Lab 6  Exercise 2
 *	Exercise Description: [Light Game]
 *
 *	I acknowledge all content contained herein, excluding template or example
 *	code, is my own original work.
 *
 *	Demo Link: https://drive.google.com/file/d/1A-OIxxJrGf5z3qtQj-s3YABgreRI_ris/view?usp=sharing
 */
 
#include <avr/io.h>
#include <avr/interrupt.h>
#ifdef _SIMULATE_
#include "simAVRHeader.h"
#endif

unsigned char tmpInput = 0x00;
unsigned char tmpOutput = 0x00;

enum SM_States { START, IDLE, PRESSED, WAIT } SM_State;
enum Light_States { OFF, PAUSE, SEQ_1, SEQ_2, SEQ_3, SEQ_4 } Light_State;

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

void tick() {
	switch (SM_State) { // Transitions
		case START:
			SM_State = IDLE;
			break;
		case IDLE:
			if ( (tmpInput & 0x01) == 1)
				SM_State = PRESSED;
			break;
		case PRESSED:
			if ( (tmpInput & 0x01) == 1)
				SM_State = WAIT;
			if ( (tmpInput & 0x01) == 0)
				SM_State = IDLE;
			break;
		case WAIT:
			if ( (tmpInput & 0x01) == 0)
				SM_State = IDLE;
			break;
		default:
			SM_State = START;
	}
	
	switch (SM_State) { // Outputs
		case PRESSED:
			if (Light_State >= 2)
				Light_State = PAUSE;
			else if (Light_State == PAUSE)
				Light_State = SEQ_1;
		case WAIT:
		case IDLE:
			if (Light_State == OFF)
				tmpOutput = 0x00;
			if (Light_State == SEQ_1) {
				tmpOutput = 0x01;
				Light_State = SEQ_2;
			}
			else if (Light_State == SEQ_2) {
				tmpOutput = 0x02;
				Light_State = SEQ_3;
			}
			else if (Light_State == SEQ_3) {
				tmpOutput = 0x04;
				Light_State = SEQ_4;
			}
			else if (Light_State == SEQ_4) {
				tmpOutput = 0x02;
				Light_State = SEQ_1;
			}
			break;
		default:
			break;
	}
}

int main(void) {
	DDRD = 0x00; PORTD = 0xFF; // Configure port D's 8 pins as inputs, initialize to 1s
	DDRA = 0xFF; PORTA = 0x00; // Configure port A's 8 pins as outputs, initialize to 0s
	
	TimerSet(300);
	TimerOn();
	
	SM_State = START;
	Light_State = SEQ_1;
	
	while(1) {
		// User code (i.e. synchSM calls)
		tmpInput = ~PIND;
		tick();
		PORTA = tmpOutput;
		
		while (!TimerFlag); // Wait 1 sec
		TimerFlag = 0;
	}
	return 1;
}
