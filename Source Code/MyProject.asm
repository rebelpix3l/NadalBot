
_main:

;MyProject.c,8 :: 		void main() {
;MyProject.c,9 :: 		STATUS = STATUS | 0x20; // Select Bank 1 (set bit 5 in the status register)
	BSF        STATUS+0, 5
;MyProject.c,10 :: 		TRISB = 0xC0; // PORTB0-5 Output, 6 and 7 input
	MOVLW      192
	MOVWF      TRISB+0
;MyProject.c,11 :: 		TRISC = 0x02; //RC1 input
	MOVLW      2
	MOVWF      TRISC+0
;MyProject.c,12 :: 		STATUS = STATUS & 0xDF; // Clear bit 5 in the STATUS register (Bank0)
	MOVLW      223
	ANDWF      STATUS+0, 1
;MyProject.c,15 :: 		PORTB= 0x00;
	CLRF       PORTB+0
;MyProject.c,16 :: 		PORTC= PORTC | 0x01;  //  turn on laser
	BSF        PORTC+0, 0
;MyProject.c,17 :: 		INTCON= INTCON | 0X88;//
	MOVLW      136
	IORWF      INTCON+0, 1
;MyProject.c,20 :: 		while(1){
L_main0:
;MyProject.c,21 :: 		PORTC= PORTC & 0xF3;//Turn off Gear    1111 0011
	MOVLW      243
	ANDWF      PORTC+0, 1
;MyProject.c,22 :: 		PORTB= PORTB & 0xDF;  //turn off buzzer
	MOVLW      223
	ANDWF      PORTB+0, 1
;MyProject.c,23 :: 		if (!(PORTC &0x02)){
	BTFSC      PORTC+0, 1
	GOTO       L_main2
;MyProject.c,25 :: 		PORTB= PORTB | 0x0A;
	MOVLW      10
	IORWF      PORTB+0, 1
;MyProject.c,26 :: 		PORTB= PORTB & 0xCB;   //  turn on motors for ball shooter
	MOVLW      203
	ANDWF      PORTB+0, 1
;MyProject.c,29 :: 		myDelay( 3000)   ;
	MOVLW      184
	MOVWF      FARG_myDelay_x+0
	MOVLW      11
	MOVWF      FARG_myDelay_x+1
	CALL       _myDelay+0
;MyProject.c,30 :: 		PORTB= PORTB & 0xE1;
	MOVLW      225
	ANDWF      PORTB+0, 1
;MyProject.c,31 :: 		}
L_main2:
;MyProject.c,33 :: 		}
	GOTO       L_main0
;MyProject.c,36 :: 		}
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

;MyProject.c,39 :: 		void interrupt(void){
;MyProject.c,40 :: 		if ( !(PORTB & 0x40) )
	BTFSC      PORTB+0, 6
	GOTO       L_interrupt3
;MyProject.c,41 :: 		{ while( !(PORTB & 0x40)) {
L_interrupt4:
	BTFSC      PORTB+0, 6
	GOTO       L_interrupt5
;MyProject.c,43 :: 		left();
	CALL       _left+0
;MyProject.c,44 :: 		}
	GOTO       L_interrupt4
L_interrupt5:
;MyProject.c,45 :: 		INTCON = INTCON & 0xFE;   //check value
	MOVLW      254
	ANDWF      INTCON+0, 1
;MyProject.c,46 :: 		}
	GOTO       L_interrupt6
L_interrupt3:
;MyProject.c,48 :: 		else if ( !(PORTB & 0x80))
	BTFSC      PORTB+0, 7
	GOTO       L_interrupt7
;MyProject.c,49 :: 		{ while( !(PORTB & 0x80) )
L_interrupt8:
	BTFSC      PORTB+0, 7
	GOTO       L_interrupt9
;MyProject.c,52 :: 		right();
	CALL       _right+0
;MyProject.c,53 :: 		}
	GOTO       L_interrupt8
L_interrupt9:
;MyProject.c,54 :: 		INTCON = INTCON & 0xFE;                //check value
	MOVLW      254
	ANDWF      INTCON+0, 1
;MyProject.c,55 :: 		}
L_interrupt7:
L_interrupt6:
;MyProject.c,56 :: 		}
L_end_interrupt:
L__interrupt18:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_left:

;MyProject.c,60 :: 		void left(){
;MyProject.c,61 :: 		PORTB= PORTB | 0x20; //B3 Buzzer ON
	BSF        PORTB+0, 5
;MyProject.c,62 :: 		PORTC= PORTC & 0xFB;// GEAR ON, select 1:0; XXXX X0XX
	MOVLW      251
	ANDWF      PORTC+0, 1
;MyProject.c,63 :: 		PORTC= PORTC | 0x08;// GEAR ON, select 1:1; XXXX 10XX
	BSF        PORTC+0, 3
;MyProject.c,67 :: 		}
L_end_left:
	RETURN
; end of _left

_right:

;MyProject.c,69 :: 		void right(){
;MyProject.c,70 :: 		PORTB= PORTB | 0x20; //B3 Buzzer ON
	BSF        PORTB+0, 5
;MyProject.c,71 :: 		PORTC= PORTC & 0xF7;// GEAR ON, select 1:0; XXXX 0XXX
	MOVLW      247
	ANDWF      PORTC+0, 1
;MyProject.c,72 :: 		PORTC= PORTC | 0x04;// GEAR ON, select 0:1  XXXX 01XX
	BSF        PORTC+0, 2
;MyProject.c,76 :: 		}
L_end_right:
	RETURN
; end of _right

_myDelay:

;MyProject.c,77 :: 		void myDelay(unsigned int mscnt){
;MyProject.c,80 :: 		for(ms=0;ms<mscnt;ms++){
	CLRF       R1+0
	CLRF       R1+1
L_myDelay10:
	MOVF       FARG_myDelay_mscnt+1, 0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__myDelay22
	MOVF       FARG_myDelay_mscnt+0, 0
	SUBWF      R1+0, 0
L__myDelay22:
	BTFSC      STATUS+0, 0
	GOTO       L_myDelay11
;MyProject.c,81 :: 		for(cnt=0;cnt<155;cnt++);//1ms
	CLRF       R3+0
	CLRF       R3+1
L_myDelay13:
	MOVLW      0
	SUBWF      R3+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__myDelay23
	MOVLW      155
	SUBWF      R3+0, 0
L__myDelay23:
	BTFSC      STATUS+0, 0
	GOTO       L_myDelay14
	INCF       R3+0, 1
	BTFSC      STATUS+0, 2
	INCF       R3+1, 1
	GOTO       L_myDelay13
L_myDelay14:
;MyProject.c,80 :: 		for(ms=0;ms<mscnt;ms++){
	INCF       R1+0, 1
	BTFSC      STATUS+0, 2
	INCF       R1+1, 1
;MyProject.c,82 :: 		}
	GOTO       L_myDelay10
L_myDelay11:
;MyProject.c,83 :: 		}
L_end_myDelay:
	RETURN
; end of _myDelay
