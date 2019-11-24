.SUFFIXES: .c

CC=avr-gcc
MCU=atmega328p
CFLAGS=-Wall -Os -std=c11 -mmcu=${MCU} -DF_CPU=16000000L
HEXFLAGS=-j .text -j .data -j .text.startup -O ihex
AVRDUDEFLAGS=-p ${MCU} -c arduino -D -b57600 -P /dev/ttyUSB0 -U
OBJS=main.o
HEX=main.hex

default: ${HEX}

all: upload

upload: ${HEX}
	avrdude ${AVRDUDEFLAGS} flash:w:${HEX}:i

%.bin: ${OBJS}
	avr-ld -o $@ $^

%.hex: %.bin
	avr-objcopy ${HEXFLAGS} $< $@

clean:
	rm -f *.o *.hex *.bin

prepare-port:
	sudo stty -F /dev/ttyACM0 cs8 9600 ignbrk -brkint -imaxbel -opost -onlcr -isig -icanon -iexten -echo -echoe -echok -echoctl -echoke noflsh -ixon -crtscts

.PHONY: all upload default clean prepare-port
