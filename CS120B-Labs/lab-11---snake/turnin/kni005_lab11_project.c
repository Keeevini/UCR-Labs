/*	Author: kni005
 *	Partner(s) Name: 
 *	Lab Section: 021
 *	Assignment: Lab 11  Exercise 0
 *	Exercise Description: [Snake]
 *
 *	I acknowledge all content contained herein, excluding template or example
 *	code, is my own original work.
 *
 *	Demo Link: https://drive.google.com/file/d/1N0dExCyKHOptC91-A93lNAM1n6AkXrts/view?usp=sharing
 */
 
#include <stdlib.h>
#include <time.h>
 
#include <avr/io.h>
#include <avr/interrupt.h>
#ifdef _SIMULATE_
#include "simAVRHeader.h"
#endif


//---------------------Global Variables---------------------

typedef enum { false, true } bool;

// Board Display
unsigned char rows_display[5] = {0x00, 0x00, 0x00, 0x00, 0x00};

// Input/Output Variables
unsigned char output_c = 0x00;
unsigned char output_d = 0x00;
unsigned char input_a = 0xFF;
double input_pwm = 0.00;
double output_pwm = 0.00;

// Game Variables
bool play = false;
bool collision = false;

enum snake_dir_states {snake_none, snake_left, snake_right, snake_up, snake_down} snake_dir;
unsigned char snake_row[6] = {0x02, 0x02, 0x00, 0x00, 0x00, 0x00};
unsigned char snake_col[6] = {0x04, 0x03, 0x00, 0x00, 0x00, 0x00};
unsigned char snake_size = 0x02;

unsigned char apple[2] = {0x05, 0x08};

// Counters
int game_counter = 0;
int music_counter = 0;
int note = 0;

// Music
enum song_states {song_none, song_menu, song_fancy, song_riot} song_state;
// double notes_menu[19] = {55, 220, 246.94, 329.63, 0, 69.30, 220, 246.94, 329.63, 0, 73.42, 220, 246.94, 329.63, 0, 73.42, 0, 69.30, 0};
double notes_menu[19] = {110, 440, 493.88, 659.26, 0, 138.6, 440, 493.88, 659.26, 0, 146.84, 440, 493.88, 659.26, 0, 146.84, 0, 138.6, 0};
double beat_menu[19] = {20, 20, 20, 60, 40, 20, 20, 20, 60, 40, 20, 20, 20, 60, 40, 40, 40, 40, 40};
int menu_size = 19;

double notes_fancy[30] = {523.25, 0, 523.25, 0, 523.25, 466.16, 0, 466.16, 0, 466.16, 415.30, 392, 415.3, 932.33, 0, 932.33, 783.99, 0, 783.99, 622.26, 0, 622.26, 466.16, 523.25, 0, 932.33, 0, 783.99, 698.46, 783.99};
double beat_fancy[30] = {15, 1, 35, 10, 10, 30, 10, 10, 1, 10, 10, 10, 10, 10, 1, 10, 10, 1, 10, 10, 1, 10, 10, 10, 10, 10, 10, 20, 10, 20};
int fancy_size = 30;

// double notes_riot[32] = {196, 0, 196, 0, 196, 392, 196, 220, 238.88, 0, 238.88, 0, 238.88, 293.66, 261.63, 293.66, 146.83, 0, 146.83, 0, 146.83, 293.66, 261.63, 293.66, 174.61, 0, 174.61, 0, 174.61, 293.66, 261.63, 293.66};
double notes_riot[32] = {392, 0, 392, 0, 392, 784, 392, 440, 466.16, 0, 466.16, 0, 466.16, 587.32, 523.26, 587.32, 293.66, 0, 293.66, 0, 293.66, 587.32, 523.26, 587.32, 349.22, 0, 349.22, 0, 349.22, 587.32, 523.26, 587.32};
double beat_riot[32] = {15, 1, 10, 5, 10, 15, 15, 10, 15, 1, 10, 5, 10, 15, 15, 10, 15, 1, 10, 5, 10, 15, 15, 10, 15, 1, 10, 5, 10, 15, 15, 10};
int riot_size = 32;

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

//---------------------------Helper Functions---------------------------
// Helper function that sets the bit for you
void set_bit(int row_index, int col_index, bool on) {
	
	// Setting bits
	if (col_index == 0 && on)
		rows_display[row_index] = rows_display[row_index] | 0x01;
	if (col_index == 1 && on)
		rows_display[row_index] = rows_display[row_index] | 0x02;
	if (col_index == 2 && on)
		rows_display[row_index] = rows_display[row_index] | 0x04;
	if (col_index == 3 && on)
		rows_display[row_index] = rows_display[row_index] | 0x08;
	if (col_index == 4 && on)
		rows_display[row_index] = rows_display[row_index] | 0x10;
	if (col_index == 5 && on)
		rows_display[row_index] = rows_display[row_index] | 0x20;
	if (col_index == 6 && on)
		rows_display[row_index] = rows_display[row_index] | 0x40;
	if (col_index == 7 && on)
		rows_display[row_index] = rows_display[row_index] | 0x80;

	// Clearing bits
	if (col_index == 0 && !on)
		rows_display[row_index] = rows_display[row_index] & 0xFE;
	if (col_index == 1 && !on)
		rows_display[row_index] = rows_display[row_index] & 0xFD;
	if (col_index == 2 && !on)
		rows_display[row_index] = rows_display[row_index] & 0xFB;
	if (col_index == 3 && !on)
		rows_display[row_index] = rows_display[row_index] & 0xF7;
	if (col_index == 4 && !on)
		rows_display[row_index] = rows_display[row_index] & 0xEF;
	if (col_index == 5 && !on)
		rows_display[row_index] = rows_display[row_index] & 0xDF;
	if (col_index == 6 && !on)
		rows_display[row_index] = rows_display[row_index] & 0xBF;
	if (col_index == 7 && !on)
		rows_display[row_index] = rows_display[row_index] & 0x7F;
}

bool check_bit(int row_index, int col_index) {
	
	// check bits
	if (col_index == 0)
		if ( (rows_display[row_index] & 0x01) == 0x01)
			return true;
	if (col_index == 1)
		if ( (rows_display[row_index] & 0x02) == 0x02)
			return true;
	if (col_index == 2)
		if ( (rows_display[row_index] & 0x04) == 0x04)
			return true;
	if (col_index == 3)
		if ( (rows_display[row_index] & 0x08) == 0x08)
			return true;
	if (col_index == 4)
		if ( (rows_display[row_index] & 0x10) == 0x10)
			return true;
	if (col_index == 5)
		if ( (rows_display[row_index] & 0x20) == 0x20)
			return true;
	if (col_index == 6)
		if ( (rows_display[row_index] & 0x40) == 0x40)
			return true;
	if (col_index == 7)
		if ( (rows_display[row_index] & 0x80) == 0x80)
			return true;
	
	return false;
}

// Helper function that clears all the rows_display
void clear_screen() {
	rows_display[0] = 0x00;
	rows_display[1] = 0x00;
	rows_display[2] = 0x00;
	rows_display[3] = 0x00;
	rows_display[4] = 0x00;
}

// Helper function to generate a new apple
void generate_apple() {

	apple[0] = rand() % 5;
	apple[1] = rand() % 8;
	
	// Check if the apple generated is in the snake
	bool in_snake = false;
	for (int i = 0; i < snake_size; ++i) {
		if (apple[0] == snake_row[i] && apple[1] == snake_col[i])
			in_snake = true;
	}
	if (in_snake)
		generate_apple();
}

// Helper function to manage checking and eating an apple
void check_apple() {
	
	bool eatApple = false;
		
	if (snake_row[0] > 0 && snake_dir == snake_up && snake_row[0]-1 == apple[0] && snake_col[0] == apple[1])
		eatApple = true;
	if (snake_row[0] < 4 && snake_dir == snake_down && snake_row[0]+1 == apple[0] && snake_col[0] == apple[1])
		eatApple = true;
	if (snake_col[0] > 0 && snake_dir == snake_right && snake_row[0] == apple[0] && snake_col[0]-1 == apple[1])
		eatApple = true;
	if (snake_col[0] < 7 && snake_dir == snake_left && snake_row[0] == apple[0] && snake_col[0]+1 == apple[1])
		eatApple = true;
	
	if (eatApple) {
		// Enlargen snake
		++snake_size;
		
		// Generate new apple
		generate_apple();
	}
}

// Helper function to check for collisions
bool check_collision(int row, int col) {
	bool in_snake = false;
	for (int i = 0; i < snake_size; ++i) {
		if (row == snake_row[i] && col == snake_col[i])
			in_snake = true;
	}
	
	return in_snake;
	
}

// Helper function to move the snake
void move_snake() {
	
	check_apple();
	
	unsigned char tmp_row = snake_row[0];
	unsigned char tmp_col = snake_col[0];
	
	if (snake_row[0] > 0 && snake_dir == snake_up)
		tmp_row = snake_row[0] - 1;
	if (snake_row[0] < 4 && snake_dir == snake_down)
		tmp_row = snake_row[0] + 1;
	if (snake_col[0] > 0 && snake_dir == snake_right)
		tmp_col = snake_col[0] - 1;
	if (snake_col[0] < 7 && snake_dir == snake_left)
		tmp_col = snake_col[0] + 1;
	
	if(tmp_row != snake_row[0] || tmp_col != snake_col[0]) {
		
		// Move the array one back (while removing the last one)
		for (int i = snake_size-1; i > 0; --i) {
			snake_row[i] = snake_row[i-1];
			snake_col[i] = snake_col[i-1];
		}
		
		collision = check_collision(tmp_row, tmp_col);
	}
	
	snake_row[0] = tmp_row;
	snake_col[0] = tmp_col;
}

// Helper function to draw the apple
void draw_apple() {
	if (apple[0] < 5 && apple[0] >= 0 && apple[1] < 8 && apple[1] >= 0)
		set_bit(apple[0], apple[1], true);
}

// Helper function to draw the snake
void draw_snake() {

	for( int i = 0; i < snake_size; ++i) {
		set_bit(snake_row[i], snake_col[i], true);
	}
}

//-------------------------------Synch SMs--------------------------------------

enum music_states {music_off, music_play};
enum snake_states {snake_off, snake_on};
enum game_states {game_menu, game_play, game_win, game_lose};
enum input_states {input_idle, input_right, input_left, input_up, input_down, input_song, input_wait};
enum display_states {row0, row1, row2, row3, row4, reset};

// Tick function to manage the music
int music_tick(int state) {
	
	int tmp_size = 0;
	int tmp_beat = 0;
	double tmp_note = 0.00;

	
	// Transitions
	switch (state) {
		case music_off:
			state = music_play;
			music_counter = 0;
			note = 0;
			break;
		case music_play:
			break;
		default:
			break;
	}
	
	// Actions
	switch (state) {
		case music_off:
			break;
		case music_play:
			// Length
			switch(song_state) {
				case song_none:
					tmp_size = 0;
					break;
				case song_menu:
					tmp_size = menu_size;
					break;
				case song_fancy:
					tmp_size = fancy_size;
					break;
				case song_riot:
					tmp_size = riot_size;
					break;
			}
			
			// Reset the song
			if (note > tmp_size)
				note = 0;
			
			// Beat
			switch (song_state) {
				case song_none:
					tmp_beat = -1;
					break;
				case song_menu:
					tmp_beat = beat_menu[note];
					break;
				case song_fancy:
					tmp_beat = beat_fancy[note];
					break;
				case song_riot:
					tmp_beat = beat_riot[note];
					break;
			}
			
			if (music_counter >= tmp_beat) {
				music_counter = 0;
				++note;
			}
			++music_counter;
			
			// Note
			switch(song_state) {
				case song_none:
					tmp_note = 0;
					break;
				case song_menu:
					tmp_note = notes_menu[note];
					break;
				case song_fancy:
					tmp_note = notes_fancy[note];
					break;
				case song_riot:
					tmp_note = notes_riot[note];
					break;
			}
		
			input_pwm = tmp_note;
			break;
	}
	
	// Only sets PWM when it changes to conserve power
	if(input_pwm != output_pwm) {
		output_pwm = input_pwm;
		set_PWM(output_pwm);
	}
	
	return state;
}

// Tick function to update the snake
int snake_tick(int state) {
	
	// Transitions
	switch (state) {
		case snake_off:
			if (play == true)
				state = snake_on;
			break;
		case snake_on:
			if (play == false)
				state = snake_off;
			break;
		default:
			break;
	}
	
	// Actions
	switch (state) {
		case snake_off:
			break;
		case snake_on:
			
			if (apple[0] == 0x05 && apple[1] == 0x08)
				generate_apple();
				
			move_snake();
			
			break;
		default:
			break;
	}
	return state;
}

// Tick function to manage the game state
int game_tick(int state) {
	
	// Transitions
	switch (state) {
		case game_menu:
			if (snake_dir != snake_none) {
				
				// state = game_win;
				// play = false;
				// game_counter = 0;
				// snake_dir = snake_none;
				
				state = game_play;
				play = true;
				collision = false;
				
				song_state = song_riot;
				note = 0;
				music_counter = 0;
				
				snake_row[0] = 0x02;
				snake_row[1] = 0x02;
				snake_col[0] = 0x04;
				snake_col[1] = 0x03;
				snake_size = 0x02;

				apple[0] = 0x05;
				apple[1] = 0x08;
			}
			break;
			
		case game_play:
			if (snake_size >= 6) {
				state = game_win;
				play = false;
				game_counter = 0;
				snake_dir = snake_none;
				
				song_state = song_menu;
				note = 0;
				music_counter = 0;
				
			}
			if (collision) {
				state = game_lose;
				play = false;
				game_counter = 0;
				snake_dir = snake_none;
				
				song_state = song_menu;
				note = 0;
				music_counter = 0;
			}
			
			break;
		case game_win:
			if (game_counter >= 50) {
				state = game_menu;
			}
			++game_counter;
			break;
		case game_lose:
			if (game_counter >= 50) {
				state = game_menu;
			}
			++game_counter;
			break;
		default:
			break;
	}
	
	clear_screen();
	
	// Actions
	switch (state) {
		case game_menu:
			rows_display[0] = 0x81;
			rows_display[1] = 0x81;
			rows_display[2] = 0x81;
			rows_display[3] = 0x81;
			rows_display[4] = 0x81;
			break;
		case game_play:
			draw_apple();
			draw_snake();
			break;
		case game_win:
			rows_display[0] = 0x49;
			rows_display[1] = 0x49;
			rows_display[2] = 0x49;
			rows_display[3] = 0x2A;
			rows_display[4] = 0x14;
			break;
		case game_lose:
			rows_display[0] = 0x44;
			rows_display[1] = 0x28;
			rows_display[2] = 0x10;
			rows_display[3] = 0x28;
			rows_display[4] = 0x44;
			break;
		default:
			break;
	}
	return state;
}

// Tick function to get user inputs
int input_tick(int state) {
	
	// Transitions
	switch (state) {
		case input_idle:
			if ( (input_a & 0x1F) == 0x01)
				state = input_right;
			else if ( (input_a & 0x1F) == 0x02)
				state = input_up;
			else if ( (input_a & 0x1F) == 0x04)
				state = input_down;
			else if ( (input_a & 0x1F) == 0x08)
				state = input_left;
			else if ( (input_a & 0x1F) == 0x10)
				state = input_song;
			break;
		case input_right:
			if ( (input_a & 0x1F) == 0x00)
				state = input_idle;
			else
				state = input_wait;
			break;
		case input_up:
			if ( (input_a & 0x1F) == 0x00)
				state = input_idle;
			else
				state = input_wait;
			break;
		case input_down:
			if ( (input_a & 0x1F) == 0x00)
				state = input_idle;
			else
				state = input_wait;
			break;
		case input_left:
			if ( (input_a & 0x1F) == 0x00)
				state = input_idle;
			else
				state = input_wait;
			break;
		case input_song:
			if ( (input_a & 0x1F) == 0x00)
				state = input_idle;
			else
				state = input_wait;
			break;
		case input_wait:
			if ( (input_a & 0x1F) == 0x00)
				state = input_idle;
			break;
		default:
			break;
	}
	
	// Actions
	switch (state) {
		case input_idle:
			break;
		case input_right:
			snake_dir = snake_right;
			break;
		case input_left:
			snake_dir = snake_left;
			break;
		case input_up:
			snake_dir = snake_up;
			break;
		case input_down:
			snake_dir = snake_down;
			break;
		case input_song:
			
			// Change songs
			switch(song_state) {
				case song_none:
					break;
				case song_menu:
					song_state = song_riot;
					note = 0;
					music_counter = 0;
					break;
				case song_riot:
					song_state = song_fancy;
					note = 0;
					music_counter = 0;
					break;
				case song_fancy:
					song_state = song_menu;
					note = 0;
					music_counter = 0;
					break;
			}
			break;
		case input_wait:
			break;
		default:
			break;
	}
	
	return state;
}
			
// Tick function to display the board
int display_tick(int state) {
	
	// Local Variables
	static unsigned char pattern = 0x80;	// LED pattern - 0: LED off; 1: LED on
	static unsigned char row = 0xFE;		// Row(s) displaying pattern.
											// 0: display pattern on row
											// 1: do NOT display pattern on row
	
	// Transitions
	switch (state) {
			case reset:
				break;
			case row0:
				state = row1;
				break;
			case row1:
				state = row2;
				break;
			case row2:
				state = row3;
				break;
			case row3:
				state = row4;
				break;
			case row4:
				state = row0;
				break;
			default:
				state = reset;
				break;
	}
	
	// Actions
	switch (state) {
		case reset:
			break;
		case row0:
			pattern = rows_display[0];
			row = 0xFE;
			break;
		case row1:
			pattern = rows_display[1];
			row = 0xFD;
			break;
		case row2:
			pattern = rows_display[2];
			row = 0xFB;
			break;
		case row3:
			pattern = rows_display[3];
			row = 0xF7;
			break;
		case row4:
			pattern = rows_display[4];
			row = 0xEF;
			break;
		default:
			break;
	}
	output_c = pattern;	// Pattern to display
	output_d = row;		// Row(s) displaying pattern
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
	
	srand(time(NULL));
	snake_dir = snake_none;
	song_state = song_menu;
	
	task tasks[5];
	const unsigned short tasks_size = 5;
	
	tasks[0].state = row0;
	tasks[0].period = 2;
	tasks[0].elapsedTime = 2;
	tasks[0].TickFct = &display_tick;
	
	tasks[1].state = snake_off;
	tasks[1].period = 1000;
	tasks[1].elapsedTime = 1000;
	tasks[1].TickFct = &snake_tick;
	
	tasks[2].state = input_idle;
	tasks[2].period = 25;
	tasks[2].elapsedTime = 25;
	tasks[2].TickFct = &input_tick;
	
	tasks[3].state = game_menu;
	tasks[3].period = 100;
	tasks[3].elapsedTime = 100;
	tasks[3].TickFct = &game_tick;
	
	tasks[4].state = music_off;
	tasks[4].period = 25;
	tasks[4].elapsedTime = 25;
	tasks[4].TickFct = &music_tick;
	
	
	TimerSet(1);
	TimerOn();
	PWM_on();
	set_PWM(0);
	
	unsigned short i; // Scheduler for-loop iterator
	while(1) {
		input_a = ~PINA;
		
		for(i=0; i<tasks_size; ++i) { // Scheduler code
			if(tasks[i].elapsedTime >= tasks[i].period) { // Task is ready to tick
				tasks[i].state = tasks[i].TickFct(tasks[i].state); // Set next state
				tasks[i].elapsedTime = 0; // Reset the elapsed time for next tick
			}
			tasks[i].elapsedTime += 1;
		}
		
		PORTC = output_c;
		PORTD = output_d;

		while(!TimerFlag);
		TimerFlag = 0;
	}
	
	return 0; // Error: Program should not exit!
}

/*

Music for reference

Animal Crossing New Horizon 2am 1*20
A1	1	55
A3	1	220
B3	1	246.94
E4	3	329.63
0	2	0 
C#2	1	69.30
A3	1	220
B3	1	246.94
E4	3	329.63
0	2	0
D2	1	73.42
A3	1	220
B3	1	246.94
E4	3	329.63
0	2	0
D2	2	73.42
0	2	0
C#2	2	69.30
0	2	0

Fancy Twice 1*10
C5	1.5	523.25		
0	0	0
C5	3.5	523.25		
0	1	0
C5	1	523.25
Bb4	3	466.16
0	1	0
Bb4	1	466.16
0	0	0
Bb4	1	466.16
Ab4	1	415.30
G4	1	392.00
Ab4	1	415.30
Bb5	1	932.33
0	0	0
Bb5	1	932.33
G5	1	783.99
0	0	0
G5	1	783.99
Eb5	1	622.26
0	0	0
Eb5	1	622.26
Bb4	1	466.16
C5	1	523.25
0	1	0
Bb5	1	932.33
0	1	0
G5	2	783.99
F5	1	698.46
G5	2	783.99

Virtual Riot 1*5
G3	3	196
0	0	0
G3	2	196
0	1	0
G3	2	196
G4	3	392
G3	3	196
A3	2	220
Bb3	3	238.88
0	0	0
Bb3	2	238.88
0	1	0
Bb3	2	238.88
D4	3	293.66
C4	3	261.63
D4	2	293.66
D3	3	146.83
0	0	0
D3	2	146.83
0	1	0
D3	2	146.83
D4	3	293.66
C4	3	261.63
D4	2	293.66
F3	3	174.61
0	0	0
F3	2	174.61
0	1	0
F3	2	174.61
D4	3	293.66
C4	3	261.63
D4	2	293.66
*/
