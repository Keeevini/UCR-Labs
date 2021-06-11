/*	Author: kni005
 *	Partner(s) Name: 
 *	Lab Section: 021
 *	Assignment: Lab 11  Exercise 0
 *	Exercise Description: [Snake]
 *
 *	I acknowledge all content contained herein, excluding template or example
 *	code, is my own original work.
 *
 *	Demo Link: 
 */
 
#include <avr/io.h>
#include <avr/interrupt.h>
#ifdef _SIMULATE_
#include "simAVRHeader.h"
#endif

//-------------------------------------------Timer-------------------------------------------------
volatile unsigned char TimerFlag = 0; // TimerISR() sets this to 1. C programmer should clear to 0.

// Internal variables for mapping AVR's ISR to our cleaner TimerISR model.
unsigned long _avr_timer_M = 1; // Start count from here, down to 0. Default 1ms
unsigned long _avr_timer_cntcurr = 0; // Current internal count of 1ms ticks

// Set TimerISR() to tick every M ms
void TimerSet(unsigned long M) {
	_avr_timer_M = M;
	_avr_timer_cntcurr = _avr_timer_M;
}

void TimerOn() {
	// AVR timer/counter controller register TCCR1
	TCCR1B 	= 0x0B;	// bit3 = 1: CTC mode (clear timer on compare)
					// bit2bit1bit0=011: prescaler /64
					// 00001011: 0x0B
					// SO, 8 MHz clock or 8,000,000 /64 = 125,000 ticks/s
					// Thus, TCNT1 register will count at 125,000 ticks/s

	// AVR output compare register OCR1A.
	OCR1A 	= 125;	// Timer interrupt will be generated when TCNT1==OCR1A
					// We want a 1 ms tick. 0.001 s * 125,000 ticks/s = 125
					// So when TCNT1 register equals 125,
					// 1 ms has passed. Thus, we compare to 125.
					// AVR timer interrupt mask register

	TIMSK1 	= 0x02; // bit1: OCIE1A -- enables compare match interrupt

	//Initialize avr counter
	TCNT1 = 0;

	// TimerISR will be called every _avr_timer_cntcurr milliseconds
	_avr_timer_cntcurr = _avr_timer_M;

	//Enable global interrupts
	SREG |= 0x80;	// 0x80: 1000000
}

void TimerOff() {
	TCCR1B 	= 0x00; // bit3bit2bit1bit0=0000: timer off
}

void TimerISR() {
	TimerFlag = 1;
}

// In our approach, the C programmer does not touch this ISR, but rather TimerISR()
ISR(TIMER1_COMPA_vect)
{
	// CPU automatically calls when TCNT0 == OCR0 (every 1 ms per TimerOn settings)
	_avr_timer_cntcurr--; 			// Count down to 0 rather than up to TOP
	if (_avr_timer_cntcurr == 0) { 	// results in a more efficient compare
		TimerISR(); 				// Call the ISR that the user uses
		_avr_timer_cntcurr = _avr_timer_M;
	}
}
//---------------------------------------End Timer-------------------------------------------------

//----------------------------Extra Functions-----------------------------------
// findGCD
unsigned long int findGCD(unsigned long int a, unsigned long int b)
{
	unsigned long int c;
	while(1){
		c = a % b;
		if( c == 0 ) { return b; }
		a = b;
		b = c;
	}
	return 0;
}

// GetBit
unsigned char GetBit(unsigned char port, unsigned char number) 
{
	return ( port & (0x01 << number) );
}

//-------------------------------End Extra Functions----------------------------

//-----------------------------------PWM Functions---------------------------------------
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
//---------------------------------End PWM Functions-------------------------------------

//------------------------------Task scheduler data structure---------------------------
// Struct for Tasks represent a running process in our simple real-time operating system
typedef struct task{
	/* Tasks should have members that include: state, period,
	a measurement of elapsed time, and a function pointer. */
	signed 	 char state; 		// Task's current state
	unsigned long period; 		// Task period
	unsigned long elapsedTime; 	// Time elapsed since last task tick
	int (*TickFct)(int); 		// Task tick function
} task;

//----------------------------End task scheduler data structure-------------------------

//-------------------------------Synch SMs--------------------------------------

enum Demo_States {shift};

// Local Variables
static unsigned char pattern = 0x80;	// LED pattern - 0: LED off; 1: LED on
static unsigned char row = 0xFE;		// Row(s) displaying pattern.
										// 0: display pattern on row
										// 1: do NOT display pattern on row

int Demo_Tick(int state) {
	
	// Transitions
	switch (state) {
			case shift:
				break;
			default:
				state = shift;
				break;
	}
	
	// Actions
	switch (state) {
		case shift:
			if (row == 0xEF && pattern == 0x01) { // Reset demo
				pattern = 0x80;
				row = 0xFE;
			} else if (pattern == 0x01) { // Move LED to start of next row
				pattern = 0x80;
				row = (row << 1) | 0x01;
			} else { // Shift LED one spot to the right on current row
				pattern >>= 1;
			}
			break;
		default:
			break;
	}
	PORTC = pattern;	// Pattern to display
	PORTD = row;		// Row(s) displaying pattern
	return state;
}

//------------------------------End Synch SMs------------------------------------

int main(void) {
	/* Insert DDR and PORT initializations */
	DDRA = 0x00; PORTA = 0xFF; // Configure port A's 8 pins as inputs, initialize to 1s
	DDRB = 0x7F; PORTB = 0x80; // Configure port B's 1 pin as inputs and 7 pins as outputs, intialize to 1s and 0s
	DDRC = 0xFF; PORTC = 0x00; // Configure port C's 8 pins as outputs, initialize to 0s
	DDRD = 0xFF; PORTD = 0x00; // Configure port D's 8 pins as outputs, initialize to 0s
	
	/* Insert your solution below */
	
	task tasks[1];
	const unsigned short tasks_size = 1;
	
	tasks[0].state = shift;
	tasks[0].period = 100;
	tasks[0].elapsedTime = 100;
	tasks[0].TickFct = &Demo_Tick;
	
	TimerSet(1);
	TimerOn();
	
	unsigned short i; // Scheduler for-loop iterator
	while(1) {
		// tmpInput_1 = ~PINB;
		// tmpInput_2 = ~PINA;
		
		for(i=0; i<tasks_size; ++i) { // Scheduler code
			if(tasks[i].elapsedTime >= tasks[i].period) { // Task is ready to tick
				tasks[i].state = tasks[i].TickFct(tasks[i].state); // Set next state
				tasks[i].elapsedTime = 0; // Reset the elapsed time for next tick
			}
			tasks[i].elapsedTime += 1;
		}
		
		while(!TimerFlag);
		TimerFlag = 0;
	}
	
	return 0; // Error: Program should not exit!
}
