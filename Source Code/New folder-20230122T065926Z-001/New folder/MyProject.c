void interrupt(void);
void left();
void right();
//void myDelay();
//void beep();
//void sensor();
void main() {
 STATUS = STATUS | 0x20; // Select Bank 1 (set bit 5 in the status register)
 TRISB = 0xC0; // PORTB0-5 Output, 6 and 7 input
 TRISC = 0x02; //RC1 input
 STATUS = STATUS & 0xDF; // Clear bit 5 in the STATUS register (Bank0)
 //PORTB= PORTB | 0x0A;  //
// PORTB= PORTB & 0xCB;   //
 PORTB= 0x00;
 PORTC= PORTC | 0x01;  //  turn on laser
 INTCON= INTCON | 0X88;//
 //INTCON = INTCON & 0XC8; // interrupt enable

while(1){
 PORTC= PORTC & 0xF3;//Turn off Gear    1111 0011
 PORTB= PORTB & 0xDF;  //turn off buzzer
 if (!(PORTC &0x02)){

            PORTB= PORTB | 0x0A;
            PORTB= PORTB & 0xCB;   //  turn on motors for ball shooter
           //
           //PORTB= PORTB | 0x0A;
            delay_ms( 3000)   ;
            PORTB= PORTB & 0xE1;
                    }

 }


 }


void interrupt(void){
  if ( !(PORTB & 0x40) )
  { while( !(PORTB & 0x40)) {
 // PORTB= PORTB | 0x20;
 left();
       }
       INTCON = INTCON & 0xFE;   //check value
       }

  else if ( !(PORTB & 0x80))
  { while( !(PORTB & 0x80) )
  {
  // PORTB= PORTB | 0x20;
  right();
       }
       INTCON = INTCON & 0xFE;                //check value
       }
  }



void left(){
 PORTB= PORTB | 0x20; //B3 Buzzer ON
 PORTC= PORTC & 0xFB;// GEAR ON, select 1:0; XXXX X0XX
 PORTC= PORTC | 0x08;// GEAR ON, select 1:1; XXXX 10XX
 //myDelay();
//PORTC= PORTC & 0xF3; //GEAR OFF  1111 0011
 //PORTB= PORTB & 0xBF;//B5 Buzzer OFF
}

void right(){
 PORTB= PORTB | 0x20; //B3 Buzzer ON
 PORTC= PORTC & 0xF7;// GEAR ON, select 1:0; XXXX 0XXX
 PORTC= PORTC | 0x04;// GEAR ON, select 0:1  XXXX 01XX
 //myDelay();

 //PORTB= PORTB & 0xBF;//B5 Buzzer OFF
}
//void myDelay(){

//}