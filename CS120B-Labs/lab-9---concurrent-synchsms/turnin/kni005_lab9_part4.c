/*	Author: kni005
 *  	Partner(s) Name: 
 *	Lab Section: 021
 *	Assignment: Lab 9  Exercise 3
 *	Exercise Description: [Lights and Speaker]
 *
 *	I acknowledge all content contained herein, excluding template or example
 *	code, is my own original work.
 *
 *	Demo Link: https://drive.google.com/file/d/13J-STjxpJKiLriit6TqCrZrJooU0pkmc/view?usp=sharing
 */
 
#include <avr/io.h>
#include <avr/interrupt.h>
#ifdef _SIMULATE_
#include "simAVRHeader.h"
#endif

unsigned char tmpInput = 0x00;
unsigned char tmpOutput_1 = 0x00;
unsigned char tmpOutput_2 = 0x00;
unsigned char tmpOutput_3 = 0x00;
unsigned char tmpOutput = 0x00;

unsigned char counter_3 = 0x00;
unsigned char frequency = 0x00;

enum SM_States_1 { START1, FIRST, SECOND, THIRD } SM_State_1;
enum SM_States_2 { START2, ON, OFF } SM_State_2;
enum SM_States_3 { START3, IDLE, INC, DEC, WAIT } SM_State_3;
enum SM_States_4 { START4, SPEAKER_ON, SPEAKER_OFF } SM_State_4;
enum SM_States_5 { START5, OUTPUT } SM_State_5;

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
			SM_State_3 = IDLE;
			break;
		case IDLE:
			if ( (tmpInput & 0x03) == 0x01)
				SM_State_3 = INC;
			if ( (tmpInput & 0x03) == 0x02)
				SM_State_3 = DEC;
			break;
		case INC:
			if ( (tmpInput & 0x03) == 0x00)
				SM_State_3 = IDLE;
			else
				SM_State_3 = WAIT;
			break;
		case DEC:
			if ( (tmpInput & 0x03) == 0x00)
				SM_State_3 = IDLE;
			else
				SM_State_3 = WAIT;
			break;
		default:
			SM_State_3 = START3;
	}
	
	switch (SM_State_3) { // Outputs
		case INC:
			if (frequency <= 10)
				++frequency;
			break;
		case DEC:
			if (frequency >= 2)
				--frequency;
			break;
		case WAIT:
		case IDLE:
		default:
			break;
	}
}

void tick4() {
	switch (SM_State_4) { // Transitions
		case START4:
			SM_State_4 = SPEAKER_OFF;
			break;
		case SPEAKER_OFF:
			if ( (tmpInput & 0x04) == 0x04) {
				counter_3 = 0x01;
				SM_State_4 = SPEAKER_ON;
			}
			break;
		case SPEAKER_ON:
			if ( (tmpInput & 0x04) == 0x00)
				SM_State_4 = SPEAKER_OFF;
			break;
		default:
			SM_State_4 = START4;
	}
	
	switch (SM_State_4) { // Outputs
		case SPEAKER_ON:
			if (counter_3 >= frequency + 1) {
				if (counter_3 == frequency * 2)
					counter_3 = 0;
				tmpOutput_3 = 0x10;
			}
			else
				tmpOutput_3 = 0x00;
			++counter_3;
			break;
		case SPEAKER_OFF:
		default:
			break;
	}
}

void tick5() {
	switch (SM_State_5) { // Transitions
		case START5:
			SM_State_5 = OUTPUT;
			break;
		case OUTPUT:
			break;
		default:
			break;
	}
	
	switch (SM_State_5) { // Outputs
		case OUTPUT:
			tmpOutput = tmpOutput_1 | tmpOutput_2 | tmpOutput_3;
			break;
		default:
			break;
	}
}

int main(void) {
	DDRA = 0x00; PORTA = 0xFF; // Configure port A's 8 pins as inputs, initialize to 1s
	DDRB = 0xFF; PORTB = 0x00; // Configure port B's 8 pins as outputs, initialize to 0s
	
	TimerSet(1);
	TimerOn();
	
	SM_State_1 = START1;
	SM_State_2 = START2;
	SM_State_3 = START3;
	SM_State_4 = START4;
	SM_State_5 = START5;
	
	unsigned long count_1 = 300;
	unsigned long count_2 = 1000;
	
	frequency = 1;
	
	while(1) {
		// User code (i.e. synchSM calls)
		tmpInput = ~PINA;
		
		if (count_1 == 300) {
			tick1();
			count_1 = 0;
		}
		if (count_2 == 1000) {
			tick2();
			count_2 = 0;
		}
		tick3();
		tick4();
		tick5();
		PORTB = tmpOutput;
		
		++count_1;
		++count_2;
		
		while (!TimerFlag); // Wait 1 sec
		TimerFlag = 0;
	}
	return 1;
}
