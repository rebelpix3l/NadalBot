#line 1 "C:/Users/nezar/Desktop/Embedded/Source Code/New folder-20230122T065926Z-001/New folder/MyProject.c"

void interrupt(void);
void left();
void right();
void myDelay(unsigned int x);


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


 myDelay( 3000) ;
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
void myDelay(unsigned int mscnt){
 unsigned int ms;
 unsigned int cnt;
 for(ms=0;ms<mscnt;ms++){
 for(cnt=0;cnt<155;cnt++);
 }
}
