/*	Author: kni005
 *  Partner(s) Name: 
 *	Lab Section: 021
 *	Assignment: Lab 10  Exercise 1
 *	Exercise Description: [Door Mechanism]
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

//----------------------------Get KeypadKey-------------------------------------
// Returns '\0' if no key pressed, else returns char '1', '2', ... '9', 'A', ...
// If multiple keys pressed, returns leftmost-topmost one
// Keypad must be connected to port C
/* Keypad arrangement
		PC4 PC5 PC6 PC7
	col	1	2	3	4
row
PC0	1	1 | 2 | 3 | A
PC1	2	4 | 5 | 6 | B
PC2	3	7 | 8 | 9 | C
PC3 4	* | 0 | # | D
*/

unsigned char GetKeypadKey() {

	// Check keys in col 1
	PORTC = 0xEF; // Enable col 4 with 0, disable others with 1's
	asm("nop"); // add a delay to allow PORTC to stabilize before checking
	if (GetBit(PINC,0) == 0) { return '1'; }
	if (GetBit(PINC,1) == 0) { return '4'; }
	if (GetBit(PINC,2) == 0) { return '7'; }
	if (GetBit(PINC,3) == 0) { return '*'; }

	// Check keys in col 2
	PORTC = 0xDF; // Enable col 5 with 0, disable others with 1's
	asm("nop"); // add a delay to allow PORTC to stabilize before checking
	if (GetBit(PINC,0) == 0) { return '2'; }
	if (GetBit(PINC,1) == 0) { return '5'; }
	if (GetBit(PINC,2) == 0) { return '8'; }
	if (GetBit(PINC,3) == 0) { return '0'; }

	// Check keys in col 3
	PORTC = 0xBF; // Enable col 6 with 0, disable others with 1's
	asm("nop"); // add a delay to allow PORTC to stabilize before checking
	if (GetBit(PINC,0) == 0) { return '3'; }
	if (GetBit(PINC,1) == 0) { return '6'; }
	if (GetBit(PINC,2) == 0) { return '9'; }
	if (GetBit(PINC,3) == 0) { return '#'; }

	// Check keys in col 4
	PORTC = 0x7F; // Enable col 7 with 0, disable others with 1's
	asm("nop"); // add a delay to allow PORTC to stabilize before checking
	if (GetBit(PINC,0) == 0) { return 'A'; }
	if (GetBit(PINC,1) == 0) { return 'B'; }
	if (GetBit(PINC,2) == 0) { return 'C'; }
	if (GetBit(PINC,3) == 0) { return 'D'; }
	
	return ('\0'); // default value
}
//---------------------------End Get KeypadKey----------------------------------

//-------------------------------Synch SMs--------------------------------------
enum states { START, IDLE };
unsigned char tmpB = 0x00;

int tick(int state) {
    unsigned char key;
    key = GetKeypadKey();
    switch(state) { //Outputs
        case START:
            state = IDLE;
            break;
        case IDLE:
            switch(key){
                case '\0':
                    tmpB = 0x00;
					break;
                case '1':
      	        case '2':
      	        case '3':
      	        case '4':
      	        case '5':
      	        case '6':
      	        case '7':
      	        case '8':
      	        case '9':
      	        case 'A':
      	        case 'B':
      	        case 'C':
      	        case 'D':
      	        case '*':
                case '0':
      	        case '#':
      		        tmpB = 0x80;
					break;
      	        default:
      		        tmpB = 0x1B; break;
            }
            break;
    }
    return state;
}
//------------------------------End Synch SMs------------------------------------

int main(void) {
    /* Insert DDR and PORT initializations */
    DDRB = 0xFF; PORTB = 0x00; // Configure port B's 8 pins as outputs, initialize to 0s
	DDRC = 0xF0; PORTC = 0x0F; // Configure port C's 4 pins as inputs, initialize to 1s
    
    task tasks[1];
    const unsigned short tasks_size = 1;

    tasks[0].state = START;
    tasks[0].period = 5;
    tasks[0].elapsedTime = 5;
    tasks[0].TickFct = &tick;

    TimerSet(5);
    TimerOn();
    
    unsigned short i; // Scheduler for-loop iterator
    while (1) {
        for(i=0; i< tasks_size; i++){ // Scheduler code
            if(tasks[i].elapsedTime == tasks[i].period){ // Task is ready to tick
                tasks[i].state = tasks[i].TickFct(tasks[i].state); // Set next state
                tasks[i].elapsedTime = 0; // Reset the elapsed time for next tick
            }
            tasks[i].elapsedTime += 5;
        }
		
		PORTB = tmpB;

        while(!TimerFlag);
        TimerFlag = 0;
    }
    return 0; // Error: Program should not exit!
}
