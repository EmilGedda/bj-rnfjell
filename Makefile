# Makefile for C++20 in Arduino Nano main
# Emil Gedda 2019

CC 		   := avr-gcc
CXX        := avr-g++
MCU        := atmega328p
CXXFLAGS   := -Wall -Os -std=c++2a -mmcu=${MCU} -DF_CPU=16000000L
HEXFLAGS   := -j .text -j .data -O ihex
FLASHFLAGS := -p ${MCU} -c arduino -D -b57600 -P /dev/ttyUSB0 -U

SRCS := $(shell find src -name '*.cpp')
OBJS := $(SRCS:%.cpp=%.o)

src/main: ${OBJS}

all upload: src/main.hex
	avrdude ${FLASHFLAGS} flash:w:$<:i

%.hex: %
	avr-objcopy ${HEXFLAGS} $< $@

clean:
	rm -f src/{*.o,*.hex,*.bin,main}

.PHONY: default all upload clean
