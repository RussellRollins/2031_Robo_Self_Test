; BATTERYTEST.asm
; Created by Warren Shenk
; This program performs tests the voltage of the battery

	ORG     &H000		;Begin program at x000
	
		LOAD	AllOn
		OUT		SEVENSEG
		OUT		LEDS
		OUT		LCD
	
	
		LOAD 	WR2BYTE_ADC
		OUT	I2C_CMD                                                                                                                                  
		LOAD 	Zero
		OUT 	I2C_DATA

B0:		IN	I2C_BUSY
		JZERO  OUT1
		JUMP   B0
	
	
OUT1:	IN 	I2C_DATA
		OUT 	LCD


	

CHECK:	LOAD 	RD1BYTE_ADC
		OUT 	I2C_CMD
		OUT 	I2C_DATA

B1:		IN	I2C_BUSY
		JPOS	B1
		JNEG	B1

		IN	I2C_DATA
		OUT 	LCD
		
		JUMP	CHECK
	
N:		NOP
		JUMP N

	
	
	
	
	

; This is a good place to put variables
Temp:     DW 0

; Having some constants can be very useful
Zero:     DW &H00
One:      DW 1
Two:      DW 2
Three:    DW 3
Four:     DW 4
Five:     DW 5
Six:      DW 6
Seven:    DW 7
Eight:    DW 8
Nine:     DW 9
Ten:      DW 10
AllOn:	  DW &HFFFF
Forward:  DW 100
Reverse:  DW -100
EnSonar0: DW &B00000001
EnSonar1: DW &B00000010
EnSonar2: DW &B00000100
EnSonar3: DW &B00001000
EnSonar4: DW &B00010000
EnSonar5: DW &B00100000
EnSonar6: DW &B01000000
EnSonar7: DW &B10000000
EnSonars: DW &B11111111


; I2C_COMMANDS
WR0BYTE_ADC:  DW &H0090
WR1BYTE_ADC:  DW &H1090
WR2BYTE_ADC:  DW &H2090
RD0BYTE_ADC:  DW &H0090
RD1BYTE_ADC:  DW &H0190
RD2BYTE_ADC:  DW &H0290


; IO address space map
SWITCHES: EQU &H00  ; slide switches
LEDS:     EQU &H01  ; red LEDs
TIMER:    EQU &H02  ; timer, usually running at 10 Hz
XIO:      EQU &H03  ; pushbuttons and some misc. I/0
SEVENSEG: EQU &H04  ; seven-segment display (4-digits only)
LCD:      EQU &H06  ; primitive 4-digit LCD display
LPOS:     EQU &H80  ; left wheel encoder position (read only)
LVEL:     EQU &H82  ; current left wheel velocity (read only)
LVELCMD:  EQU &H83  ; left wheel velocity command (write only)
RPOS:     EQU &H88  ; same values for right wheel...
RVEL:     EQU &H8A  ; ...
RVELCMD:  EQU &H8B  ; ...
I2C_CMD:  EQU &H90  ; I2C module's CMD register,
I2C_DATA: EQU &H91  ; ... DATA register,
I2C_BUSY: EQU &H92  ; ... and BUSY register
SONAR:    EQU &HA0  ; base address for more than 16 registers....
DIST0:    EQU &HA8  ; the eight sonar distance readings
DIST1:    EQU &HA9  ; ...
DIST2:    EQU &HAA  ; ...
DIST3:    EQU &HAB  ; ...
DIST4:    EQU &HAC  ; ...
DIST5:    EQU &HAD  ; ...
DIST6:    EQU &HAE  ; ...
DIST7:    EQU &HAF  ; ...
SONAREN:  EQU &HB2  ; register to control which sonars are enabled
XPOS:     EQU &HC0  ; Current X-position (read only)
YPOS:     EQU &HC1  ; Y-position
THETA:    EQU &HC2  ; Current rotational position of robot (0-701)