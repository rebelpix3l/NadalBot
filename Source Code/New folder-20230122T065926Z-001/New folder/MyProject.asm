
_main:

;MyProject.c,7 :: 		void main() {
;MyProject.c,8 :: 		STATUS = STATUS | 0x20; // Select Bank 1 (set bit 5 in the status register)
	BSF        STATUS+0, 5
;MyProject.c,9 :: 		TRISB = 0xC0; // PORTB0-5 Output, 6 and 7 input
	MOVLW      192
	MOVWF      TRISB+0
;MyProject.c,10 :: 		TRISC = 0x02; //RC1 input
	MOVLW      2
	MOVWF      TRISC+0
;MyProject.c,11 :: 		STATUS = STATUS & 0xDF; // Clear bit 5 in the STATUS register (Bank0)
	MOVLW      223
	ANDWF      STATUS+0, 1
;MyProject.c,14 :: 		PORTB= 0x00;
	CLRF       PORTB+0
;MyProject.c,15 :: 		PORTC= PORTC | 0x01;  //  turn on laser
	BSF        PORTC+0, 0
;MyProject.c,16 :: 		INTCON= INTCON | 0X88;//
	MOVLW      136
	IORWF      INTCON+0, 1
;MyProject.c,19 :: 		while(1){
L_main0:
;MyProject.c,20 :: 		PORTC= PORTC & 0xF3;//Turn off Gear    1111 0011
	MOVLW      243
	ANDWF      PORTC+0, 1
;MyProject.c,21 :: 		PORTB= PORTB & 0xDF;  //turn off buzzer
	MOVLW      223
	ANDWF      PORTB+0, 1
;MyProject.c,22 :: 		if (!(PORTC &0x02)){
	BTFSC      PORTC+0, 1
	GOTO       L_main2
;MyProject.c,24 :: 		PORTB= PORTB | 0x0A;
	MOVLW      10
	IORWF      PORTB+0, 1
;MyProject.c,25 :: 		PORTB= PORTB & 0xCB;   //  turn on motors for ball shooter
	MOVLW      203
	ANDWF      PORTB+0, 1
;MyProject.c,28 :: 		delay_ms( 3000)   ;
	MOVLW      31
	MOVWF      R11+0
	MOVLW      113
	MOVWF      R12+0
	MOVLW      30
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	DECFSZ     R11+0, 1
	GOTO       L_main3
	NOP
;MyProject.c,29 :: 		PORTB= PORTB & 0xE1;
	MOVLW      225
	ANDWF      PORTB+0, 1
;MyProject.c,30 :: 		}
L_main2:
;MyProject.c,32 :: 		}
	GOTO       L_main0
;MyProject.c,35 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;MyProject.c,38 :: 		void interrupt(void){
;MyProject.c,39 :: 		if ( !(PORTB & 0x40) )
	BTFSC      PORTB+0, 6
	GOTO       L_interrupt4
;MyProject.c,40 :: 		{ while( !(PORTB & 0x40)) {
L_interrupt5:
	BTFSC      PORTB+0, 6
	GOTO       L_interrupt6
;MyProject.c,42 :: 		left();
	CALL       _left+0
;MyProject.c,43 :: 		}
	GOTO       L_interrupt5
L_interrupt6:
;MyProject.c,44 :: 		INTCON = INTCON & 0xFE;   //check value
	MOVLW      254
	ANDWF      INTCON+0, 1
;MyProject.c,45 :: 		}
	GOTO       L_interrupt7
L_interrupt4:
;MyProject.c,47 :: 		else if ( !(PORTB & 0x80))
	BTFSC      PORTB+0, 7
	GOTO       L_interrupt8
;MyProject.c,48 :: 		{ while( !(PORTB & 0x80) )
L_interrupt9:
	BTFSC      PORTB+0, 7
	GOTO       L_interrupt10
;MyProject.c,51 :: 		right();
	CALL       _right+0
;MyProject.c,52 :: 		}
	GOTO       L_interrupt9
L_interrupt10:
;MyProject.c,53 :: 		INTCON = INTCON & 0xFE;                //check value
	MOVLW      254
	ANDWF      INTCON+0, 1
;MyProject.c,54 :: 		}
L_interrupt8:
L_interrupt7:
;MyProject.c,55 :: 		}
L_end_interrupt:
L__interrupt13:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_left:

;MyProject.c,59 :: 		void left(){
;MyProject.c,60 :: 		PORTB= PORTB | 0x20; //B3 Buzzer ON
	BSF        PORTB+0, 5
;MyProject.c,61 :: 		PORTC= PORTC & 0xFB;// GEAR ON, select 1:0; XXXX X0XX
	MOVLW      251
	ANDWF      PORTC+0, 1
;MyProject.c,62 :: 		PORTC= PORTC | 0x08;// GEAR ON, select 1:1; XXXX 10XX
	BSF        PORTC+0, 3
;MyProject.c,66 :: 		}
L_end_left:
	RETURN
; end of _left

_right:

;MyProject.c,68 :: 		void right(){
;MyProject.c,69 :: 		PORTB= PORTB | 0x20; //B3 Buzzer ON
	BSF        PORTB+0, 5
;MyProject.c,70 :: 		PORTC= PORTC & 0xF7;// GEAR ON, select 1:0; XXXX 0XXX
	MOVLW      247
	ANDWF      PORTC+0, 1
;MyProject.c,71 :: 		PORTC= PORTC | 0x04;// GEAR ON, select 0:1  XXXX 01XX
	BSF        PORTC+0, 2
;MyProject.c,75 :: 		}
L_end_right:
	RETURN
; end of _right
