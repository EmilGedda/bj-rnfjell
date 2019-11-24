#include <avr/io.h>
#include <util/delay.h>

#define PIN PIN4

int main() {
	DDRD |= 1 << PIN;

	while(1){
		_delay_ms(2000);
		PORTD ^= 1 << PIN;
	}
}
