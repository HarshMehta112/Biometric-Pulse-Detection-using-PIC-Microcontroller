sbit pc at RA4_bit;
sbit IR_Tx at RA3_bit;
sbit DD0_Set at RA2_bit;
sbit DD1_Set at RA1_bit;
sbit DD2_Set at RA0_bit;
sbit start at RB7_bit;
unsigned short j, DD0, DD1, DD2, DD3,x;
unsigned short pulserate, pulsecount;
unsigned int i;
// Function to Return mask for common anode 7-seg. display
unsigned short mask(unsigned short num) {
 switch (num) {
 case 0 : return 0xC0;
 case 1 : return 0xF9;
 case 2 : return 0xA4;
 case 3 : return 0xB0;
 case 4 : return 0x99;
 case 5 : return 0x92;
 case 6 : return 0x82;
 case 7 : return 0xF8;
 case 8 : return 0x80;
 case 9 : return 0x90;
 } //case end
}

void display(){
  DD0 = pulserate%10;
  DD1 = (pulserate/10)%10;
  DD2 = pulserate/100;
    DD0_Set = 0;
    DD1_Set = 1;
    DD2_Set = 1;
    PORTB = mask(DD0);//display LCD
    DD0_Set = 1;
    DD1_Set = 0;
    DD2_Set = 1;
    PORTB = mask(DD1); //display mid. digit
    DD0_Set = 1;
    DD1_Set = 1;
    DD2_Set = 0;
    PORTB = mask(DD2); //display MCD
    DD2_Set = 1;
}

void main() 
{
 CMCON = 0x07;    // Disable Comparators
 TRISA = 0b00111000; // RA4/T0CKI input, RA5 is I/P only
 TRISB = 0b10000000; // RB7 input, rest output
 OPTION_REG = 0b00101000;
while(1)
{
 x=0;

 while(IR_Tx){
    while(pc<=0){}
    while(pc>0){}
            x=x++;
    }
 pulsecount = x;
 pulserate = x;//here some modification required bcz pulse rate =pulse count/time required
 display();
 Delay_ms(5000);
}
}