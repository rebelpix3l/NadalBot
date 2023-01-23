	portb EQU 0x06
	trisb EQU 0x06
    status EQU 0x03
	portc EQU 0x07
	trisc EQU 0x07
	

			ORG 0x0000

			GOTO main

			ORG 0x0020
main:		BSF status, 5; Select Bank 1
			BSF trisc, 0; put RC0 as Input
			CLRF trisb; put portb as Output
			BCF status, 5; select Bank0
again:		BTFSC portc, 0; Is pushbutton pressed?
			GOTO notPressed
			MOVLW 0x02
			MOVWF portb; All LEDs ON
			BCF portb, 0;
			GOTO again
notPressed:
			MOVLW 0x01
			MOVWF portb; Every other LED is ON
			BCF portb, 1;
			GOTO again
			END
