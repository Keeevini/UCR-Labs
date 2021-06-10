/*	Author: kni005
 *  Partner(s) Name: 
 *	Lab Section: 021
 *	Assignment: Lab 10  Exercise 4
 *	Exercise Description: [Custom Password]
 *
 *	I acknowledge all content contained herein, excluding template or example
 *	code, is my own original work.
 *
 *	Demo Link: https://drive.google.com/file/d/15_gybWDEx5I8zhx-RLihsnjIqxwkHhSH/view?usp=sharing
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

	unsigned char tmpKey = '\0';
	unsigned char multiple = 0x00;

	// Check keys in col 1
	PORTC = 0xEF; // Enable col 4 with 0, disable others with 1's
	asm("nop"); // add a delay to allow PORTC to stabilize before checking
	if (GetBit(PINC,0) == 0 ) { tmpKey = '1'; ++multiple; }
	if (GetBit(PINC,1) == 0 ) { tmpKey = '4'; ++multiple; }
	if (GetBit(PINC,2) == 0 ) { tmpKey = '7'; ++multiple; }
	if (GetBit(PINC,3) == 0 ) { tmpKey = '*'; ++multiple; }

	// Check keys in col 2
	PORTC = 0xDF; // Enable col 5 with 0, disable others with 1's
	asm("nop"); // add a delay to allow PORTC to stabilize before checking
	if (GetBit(PINC,0) == 0 ) { tmpKey = '2'; ++multiple; }
	if (GetBit(PINC,1) == 0) { tmpKey = '5'; ++multiple; }
	if (GetBit(PINC,2) == 0) { tmpKey = '8'; ++multiple; }
	if (GetBit(PINC,3) == 0) { tmpKey = '0'; ++multiple; }

	// Check keys in col 3
	PORTC = 0xBF; // Enable col 6 with 0, disable others with 1's
	asm("nop"); // add a delay to allow PORTC to stabilize before checking
	if (GetBit(PINC,0) == 0) { tmpKey = '3'; ++multiple; }
	if (GetBit(PINC,1) == 0) { tmpKey = '6'; ++multiple; }
	if (GetBit(PINC,2) == 0) { tmpKey = '9'; ++multiple; }
	if (GetBit(PINC,3) == 0) { tmpKey = '#'; ++multiple; }

	// Check keys in col 4
	PORTC = 0x7F; // Enable col 7 with 0, disable others with 1's
	asm("nop"); // add a delay to allow PORTC to stabilize before checking
	if (GetBit(PINC,0) == 0) { tmpKey = 'A'; ++multiple; }
	if (GetBit(PINC,1) == 0) { tmpKey = 'B'; ++multiple; }
	if (GetBit(PINC,2) == 0) { tmpKey = 'C'; ++multiple; }
	if (GetBit(PINC,3) == 0) { tmpKey = 'D'; ++multiple; }
	
	if(multiple > 1)
		tmpKey = 'Z';
	
	if(multiple == 0)
		tmpKey = '\0';
	
	return tmpKey;
}

//---------------------------End Get KeypadKey----------------------------------

//-------------------------------Synch SMs--------------------------------------
enum states1 { START, IDLE, UNLOCKED, UNLOCK_POUND, WAIT_POUND, UNLOCK_1, WAIT_1, UNLOCK_2, WAIT_2, UNLOCK_3, WAIT_3, UNLOCK_4, WAIT_4 };
enum states2 { OFF, ON };
enum states3 { START_2, IDLE_2, ENTER, PAUSE_ENTER, CHANGE_1, PAUSE_1, CHANGE_2, PAUSE_2, CHANGE_3, PAUSE_3, CHANGE_4, PAUSE_4 };

double notes[6] = { 261.63, 392.00, 349.23, 392.00, 261.63 };
unsigned char password[5] = { '1', '2', '3', '4', '5' };
// unsigned char password[5] = { '1', '2', '3', '4', '5' };

unsigned char note = 0x00;
unsigned char tmpInput_1 = 0x00;
unsigned char tmpInput_2 = 0x00;
unsigned char tmpB = 0x00;

int tick1(int state) {
    unsigned char key;
    key = GetKeypadKey();
    switch (state) { // Transitions
        case START:
            state = IDLE;
            break;
        case IDLE:
            if (key == '#')
				state = UNLOCK_POUND;
            break;
		case UNLOCK_POUND:
			if (key == '\0' || key == '#')
				state = WAIT_POUND;
			else
				state = IDLE;
			break;
		case WAIT_POUND:
			if (key == '#')
				state = WAIT_POUND;
			else if (key == '\0')
				state = WAIT_POUND;
			else if (key == password[0])
				state = UNLOCK_1;
			else
				state = IDLE;
			break;
		case UNLOCK_1:
			if (key == '#')
				state = UNLOCK_POUND;
			else if (key == '\0' || key == password[0])
				state = WAIT_1;
			else
				state = IDLE;
			break;
		case WAIT_1:
			if (key == '#')
				state = UNLOCK_POUND;
			else if (key == '\0' || key == password[0])
				state = WAIT_1;
			else if (key == password[1])
				state = UNLOCK_2;
			else
				state = IDLE;
			break;
		case UNLOCK_2:
			if (key == '#')
				state = UNLOCK_POUND;
			else if (key == '\0' || key == password[1])
				state = WAIT_2;
			else
				state = IDLE;
			break;
		case WAIT_2:
			if (key == '#')
				state = UNLOCK_POUND;
			else if (key == '\0' || key == password[1])
				state = WAIT_2;
			else if (key == password[2])
				state = UNLOCK_3;
			else
				state = IDLE;
			break;
		case UNLOCK_3:
			if (key == '#')
				state = UNLOCK_POUND;
			else if (key == '\0' || key == password[2])
				state = WAIT_3;
			else
				state = IDLE;
			break;
		case WAIT_3:
			if (key == '#')
				state = UNLOCK_POUND;
			else if (key == '\0' || key == password[2])
				state = WAIT_3;
			else if (key == password[3])
				state = UNLOCK_4;
			else
				state = IDLE;
			break;
		case UNLOCK_4:
			if (key == '#')
				state = UNLOCK_POUND;
			else if (key == '\0' || key == password[3])
				state = WAIT_4;
			else
				state = IDLE;
			break;
		case WAIT_4:
			if (key == '#')
				state = UNLOCK_POUND;
			else if (key == '\0' || key == password[3])
				state = WAIT_4;
			else if (key == password[4])
				state = UNLOCKED;
			else
				state = IDLE;
			break;
		case UNLOCKED:
			if (tmpInput_1 & 0x80)
				state = IDLE;
			break;		
		default:
			state = START;
    }
	
	switch (state) { // Outputs
		case START:
			break;
		case IDLE:
		case UNLOCK_POUND:
		case WAIT_POUND:
		case UNLOCK_1:
		case WAIT_1:
		case UNLOCK_2:
		case WAIT_2:
		case UNLOCK_3:
		case WAIT_3:
		case UNLOCK_4:
		case WAIT_4:
			tmpB = 0x00;
			break;
		case UNLOCKED:
			tmpB = 0x01;
			break;
		default:
			break;
	}
    return state;
}

int tick2(int state) {
	switch (state) { // Transitions
		case OFF:
			if (tmpInput_2 & 0x80) {
				note = 0;
				state = ON;
			}
			break;
		case ON:
			if (note >= 6)
				state = OFF;
			else
				state = ON;
			break;
		default:
			state = OFF;
	}

	switch (state) { // Outputs
		case OFF:
			set_PWM(0);
			break;
		case ON:
			set_PWM(notes[note]);
			note++;
			break;
		default:
			break;
	}
	return state;
}

int tick3(int state) {
	unsigned char key;
    key = GetKeypadKey();
	
	switch (state) { // Transitions
		case START_2:
			state = IDLE_2;
			break;
		case IDLE_2:
			if (key == '*' && (tmpInput_1 & 0x80) )
				state = ENTER;
			break;
		case ENTER:
			if (key == '*' || (tmpInput_1 & 0x80) )
				state = ENTER;
			else if (key == '\0')
				state = PAUSE_ENTER;
			else
					state = IDLE_2;
			break;
		case PAUSE_ENTER:
			if (key == '\0')
				state = PAUSE_ENTER;
			else {
				password[0] = key;
				state = CHANGE_1;
			}
			break;
		case CHANGE_1:
			if (key == password[0])
				state = CHANGE_1;
			else if (key == '\0')
				state = PAUSE_1;
			break;
		case PAUSE_1:
			if (key == '\0')
				state = PAUSE_1;
			else {
				password[1] = key;
				state = CHANGE_2;
			}
			break;
		case CHANGE_2:
			if (key == password[1])
				state = CHANGE_2;
			else if (key == '\0')
				state = PAUSE_2;
			break;
		case PAUSE_2:
			if (key == '\0')
				state = PAUSE_2;
			else {
				password[2] = key;
				state = CHANGE_3;
			}
			break;
		case CHANGE_3:
			if (key == password[2])
				state = CHANGE_3;
			else if (key == '\0')
				state = PAUSE_3;
			break;
		case PAUSE_3:
			if (key == '\0')
				state = PAUSE_3;
			else {
				password[3] = key;
				state = CHANGE_4;
			}
			break;
		case CHANGE_4:
			if (key == password[3])
				state = CHANGE_4;
			else if (key == '\0')
				state = PAUSE_4;
			break;
		case PAUSE_4:
			if (key == '\0')
				state = PAUSE_4;
			else {
				password[4] = key;
				// password[0] = password[0];
				// password[1] = password[1];
				// password[2] = password[2];
				// password[3] = password[3];
				// password[4] = password[4];
				state = IDLE_2;
			}
			break;
		default:
			state = START_2;
	}
	switch (state) { // Outputs
		case IDLE_2:
		case ENTER:
		case PAUSE_ENTER:
		case CHANGE_1:
		case PAUSE_1:
		case CHANGE_2:
		case PAUSE_2:
		case CHANGE_3:
		case PAUSE_3:
		case CHANGE_4:
		case PAUSE_4:
		default:
			break;
	}
	return state;
}


//------------------------------End Synch SMs------------------------------------

int main(void) {
    /* Insert DDR and PORT initializations */
	DDRA = 0x00; PORTA = 0xFF; // Configure port A's 8 pins as inputs, initialize to 1s
    DDRB = 0x7F; PORTB = 0x80; // Configure port B's 1 pin as inputs and 7 pins as outputs, initialize to 1s and 0s
	DDRC = 0xF0; PORTC = 0x0F; // Configure port C's 4 pins as inputs and 4 pins as outputs, initialize to 1s and 0s
    
    task tasks[3];
    const unsigned short tasks_size = 3;

    tasks[0].state = START;
    tasks[0].period = 5;
    tasks[0].elapsedTime = 5;
    tasks[0].TickFct = &tick1;
	
	tasks[1].state = OFF;
	tasks[1].period = 500;
	tasks[1].elapsedTime = 500;
	tasks[1].TickFct = &tick2;
	
	tasks[2].state = START_2;
	tasks[2].period = 5;
	tasks[2].elapsedTime = 5;
	tasks[2].TickFct = &tick3;

	PWM_on();
    TimerSet(1);
    TimerOn();
    
    unsigned short i; // Scheduler for-loop iterator
    while (1) {
		
		tmpInput_1 = ~PINB;
		tmpInput_2 = ~PINA;
		
        for(i=0; i< tasks_size; i++){ // Scheduler code
            if(tasks[i].elapsedTime == tasks[i].period){ // Task is ready to tick
                tasks[i].state = tasks[i].TickFct(tasks[i].state); // Set next state
                tasks[i].elapsedTime = 0; // Reset the elapsed time for next tick
            }
            tasks[i].elapsedTime += 1;
        }
		
		PORTB = tmpB;

        while(!TimerFlag);
        TimerFlag = 0;
    }
    return 0; // Error: Program should not exit!
}
