#line 1 "C:/Users/Sara_/OneDrive/Desktop/New folder/MyProject.c"
void interrupt(void);
void left();
void right();



void main() {
 STATUS = STATUS | 0x20;
 TRISB = 0xC0;
 TRISC = 0x02;
 STATUS = STATUS & 0xDF;


 PORTB= 0x00;
 PORTC= PORTC | 0x01;
 INTCON= INTCON | 0X88;


while(1){
 PORTC= PORTC & 0xF3;
 PORTB= PORTB & 0xDF;
 if (!(PORTC &0x02)){

 PORTB= PORTB | 0x0A;
 PORTB= PORTB & 0xCB;


 delay_ms( 3000) ;
 PORTB= PORTB & 0xE1;
 }

 }


 }


void interrupt(void){
 if ( !(PORTB & 0x40) )
 { while( !(PORTB & 0x40)) {

 left();
 }
 INTCON = INTCON & 0xFE;
 }

 else if ( !(PORTB & 0x80))
 { while( !(PORTB & 0x80) )
 {

 right();
 }
 INTCON = INTCON & 0xFE;
 }
 }



void left(){
 PORTB= PORTB | 0x20;
 PORTC= PORTC & 0xFB;
 PORTC= PORTC | 0x08;



}

void right(){
 PORTB= PORTB | 0x20;
 PORTC= PORTC & 0xF7;
 PORTC= PORTC | 0x04;



}
