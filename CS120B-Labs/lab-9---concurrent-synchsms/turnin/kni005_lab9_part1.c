/*	Author: kni005
 *  	Partner(s) Name: 
 *	Lab Section: 021
 *	Assignment: Lab 9  Exercise 1
 *	Exercise Description: [Blinking Lights]
 *
 *	I acknowledge all content contained herein, excluding template or example
 *	code, is my own original work.
 *
 *	Demo Link: https://drive.google.com/file/d/1ZJLG4I_DiNC9-bgy9aTAfpTvDgrdGmoP/view?usp=sharing
 */
 
#include <avr/io.h>
#include <avr/interrupt.h>
#ifdef _SIMULATE_
#include "simAVRHeader.h"
#endif

unsigned char tmpOutput_1 = 0x00;
unsigned char tmpOutput_2 = 0x00;
unsigned char tmpOutput = 0x00;

enum SM_States_1 { START1, FIRST, SECOND, THIRD } SM_State_1;
enum SM_States_2 { START2, ON, OFF} SM_State_2;
enum SM_States_3 { START3, OUTPUT } SM_State_3;

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

void tick1() {
	switch (SM_State_1) { // Transitions
		case START1:
			SM_State_1 = FIRST;
			break;
		case FIRST:
			SM_State_1 = SECOND;
			break;
		case SECOND:
			SM_State_1 = THIRD;
			break;
		case THIRD:
			SM_State_1 = FIRST;
			break;
		default:
			SM_State_1 = START1;
	}
	
	switch (SM_State_1) { // Outputs
		case FIRST:
			tmpOutput_1 = 0x01;
			break;
		case SECOND:
			tmpOutput_1 = 0x02;
			break;
		case THIRD:
			tmpOutput_1 = 0x04;
			break;
		default:
			break;
	}
}

void tick2() {
	switch (SM_State_2) { // Transitions
		case START2:
			SM_State_2 = ON;
			break;
		case ON:
			SM_State_2 = OFF;
			break;
		case OFF:
			SM_State_2 = ON;
			break;
		default:
			SM_State_2 = START2;
	}
	
	switch (SM_State_2) { // Outputs
		case ON:
			tmpOutput_2 = 0x08;
			break;
		case OFF:
			tmpOutput_2 = 0x00;
			break;
		default:
			break;
	}
}

void tick3() {
	switch (SM_State_3) { // Transitions
		case START3:
			SM_State_3 = OUTPUT;
			break;
		case OUTPUT:
			break;
		default:
			break;
	}
	
	switch (SM_State_3) { // Outputs
		case OUTPUT:
			tmpOutput = tmpOutput_1 | tmpOutput_2;
			break;
		default:
			break;
	}
}

int main(void) {
	DDRB = 0xFF; PORTB = 0x00; // Configure port B's 8 pins as outputs, initialize to 0s
	
	TimerSet(1000);
	TimerOn();
	
	SM_State_1 = START1;
	SM_State_2 = START2;
	SM_State_3 = START3;
	
	while(1) {
		// User code (i.e. synchSM calls)
		tick1();
		tick2();
		tick3();
		PORTB = tmpOutput;
		
		while (!TimerFlag); // Wait 1 sec
		TimerFlag = 0;
	}
	return 1;
}
