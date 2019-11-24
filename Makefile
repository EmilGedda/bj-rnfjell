# Makefile for C++20 in Arduino Nano 
# Emil Gedda 2019

CXX         := avr-g++
MCU         := atmega328p
CXXFLAGS    := -Wall -Os -std=c++2a -mmcu=${MCU} -DF_CPU=16000000L
HEXFLAGS    := -j .text -j .data -O ihex
FLASHFLAG   := -p ${MCU} -c arduino -D -b57600 -P /dev/ttyUSB0 -U

SRCS := $(shell find . -name '*.cpp')
OBJS := $(SRCS:%.cpp=%.o)

default: main.hex

all upload: main.hex
	avrdude ${FLASHFLAGS} flash:w:$<:i

%.bin: ${OBJS}
	avr-ld -o $@ $^

%.hex: %.bin
	avr-objcopy ${HEXFLAGS} $< $@

clean:
	rm -f *.o *.hex *.bin

.SUFFIXES: .c
.PHONY: all upload default clean
