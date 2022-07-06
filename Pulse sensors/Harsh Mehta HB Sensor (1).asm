
_mask:

;PulseMeter.c,11 :: 		unsigned short mask(unsigned short num) {
;PulseMeter.c,12 :: 		switch (num) {
	GOTO       L_mask0
;PulseMeter.c,13 :: 		case 0 : return 0xC0;
L_mask2:
	MOVLW      192
	MOVWF      R0+0
	GOTO       L_end_mask
;PulseMeter.c,14 :: 		case 1 : return 0xF9;
L_mask3:
	MOVLW      249
	MOVWF      R0+0
	GOTO       L_end_mask
;PulseMeter.c,15 :: 		case 2 : return 0xA4;
L_mask4:
	MOVLW      164
	MOVWF      R0+0
	GOTO       L_end_mask
;PulseMeter.c,16 :: 		case 3 : return 0xB0;
L_mask5:
	MOVLW      176
	MOVWF      R0+0
	GOTO       L_end_mask
;PulseMeter.c,17 :: 		case 4 : return 0x99;
L_mask6:
	MOVLW      153
	MOVWF      R0+0
	GOTO       L_end_mask
;PulseMeter.c,18 :: 		case 5 : return 0x92;
L_mask7:
	MOVLW      146
	MOVWF      R0+0
	GOTO       L_end_mask
;PulseMeter.c,19 :: 		case 6 : return 0x82;
L_mask8:
	MOVLW      130
	MOVWF      R0+0
	GOTO       L_end_mask
;PulseMeter.c,20 :: 		case 7 : return 0xF8;
L_mask9:
	MOVLW      248
	MOVWF      R0+0
	GOTO       L_end_mask
;PulseMeter.c,21 :: 		case 8 : return 0x80;
L_mask10:
	MOVLW      128
	MOVWF      R0+0
	GOTO       L_end_mask
;PulseMeter.c,22 :: 		case 9 : return 0x90;
L_mask11:
	MOVLW      144
	MOVWF      R0+0
	GOTO       L_end_mask
;PulseMeter.c,23 :: 		} //case end
L_mask0:
	MOVF       FARG_mask_num+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_mask2
	MOVF       FARG_mask_num+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_mask3
	MOVF       FARG_mask_num+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_mask4
	MOVF       FARG_mask_num+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_mask5
	MOVF       FARG_mask_num+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_mask6
	MOVF       FARG_mask_num+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_mask7
	MOVF       FARG_mask_num+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_mask8
	MOVF       FARG_mask_num+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_mask9
	MOVF       FARG_mask_num+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_mask10
	MOVF       FARG_mask_num+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_mask11
;PulseMeter.c,24 :: 		}
L_end_mask:
	RETURN
; end of _mask

_display:

;PulseMeter.c,26 :: 		void display(){
;PulseMeter.c,27 :: 		DD0 = pulserate%10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _pulserate+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      FLOC__display+0
	MOVF       FLOC__display+0, 0
	MOVWF      _DD0+0
;PulseMeter.c,28 :: 		DD1 = (pulserate/10)%10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _pulserate+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _DD1+0
;PulseMeter.c,29 :: 		DD2 = pulserate/100;
	MOVLW      100
	MOVWF      R4+0
	MOVF       _pulserate+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R0+0, 0
	MOVWF      _DD2+0
;PulseMeter.c,30 :: 		DD0_Set = 0;
	BCF        RA2_bit+0, BitPos(RA2_bit+0)
;PulseMeter.c,31 :: 		DD1_Set = 1;
	BSF        RA1_bit+0, BitPos(RA1_bit+0)
;PulseMeter.c,32 :: 		DD2_Set = 1;
	BSF        RA0_bit+0, BitPos(RA0_bit+0)
;PulseMeter.c,33 :: 		PORTB = mask(DD0);//display LCD
	MOVF       FLOC__display+0, 0
	MOVWF      FARG_mask_num+0
	CALL       _mask+0
	MOVF       R0+0, 0
	MOVWF      PORTB+0
;PulseMeter.c,34 :: 		DD0_Set = 1;
	BSF        RA2_bit+0, BitPos(RA2_bit+0)
;PulseMeter.c,35 :: 		DD1_Set = 0;
	BCF        RA1_bit+0, BitPos(RA1_bit+0)
;PulseMeter.c,36 :: 		DD2_Set = 1;
	BSF        RA0_bit+0, BitPos(RA0_bit+0)
;PulseMeter.c,37 :: 		PORTB = mask(DD1); //display mid. digit
	MOVF       _DD1+0, 0
	MOVWF      FARG_mask_num+0
	CALL       _mask+0
	MOVF       R0+0, 0
	MOVWF      PORTB+0
;PulseMeter.c,38 :: 		DD0_Set = 1;
	BSF        RA2_bit+0, BitPos(RA2_bit+0)
;PulseMeter.c,39 :: 		DD1_Set = 1;
	BSF        RA1_bit+0, BitPos(RA1_bit+0)
;PulseMeter.c,40 :: 		DD2_Set = 0;
	BCF        RA0_bit+0, BitPos(RA0_bit+0)
;PulseMeter.c,41 :: 		PORTB = mask(DD2); //display MCD
	MOVF       _DD2+0, 0
	MOVWF      FARG_mask_num+0
	CALL       _mask+0
	MOVF       R0+0, 0
	MOVWF      PORTB+0
;PulseMeter.c,42 :: 		DD2_Set = 1;
	BSF        RA0_bit+0, BitPos(RA0_bit+0)
;PulseMeter.c,43 :: 		}
L_end_display:
	RETURN
; end of _display

_main:

;PulseMeter.c,45 :: 		void main()
;PulseMeter.c,47 :: 		CMCON = 0x07;    // Disable Comparators
	MOVLW      7
	MOVWF      CMCON+0
;PulseMeter.c,48 :: 		TRISA = 0b00111000; // RA4/T0CKI input, RA5 is I/P only
	MOVLW      56
	MOVWF      TRISA+0
;PulseMeter.c,49 :: 		TRISB = 0b10000000; // RB7 input, rest output
	MOVLW      128
	MOVWF      TRISB+0
;PulseMeter.c,50 :: 		OPTION_REG = 0b00101000;
	MOVLW      40
	MOVWF      OPTION_REG+0
;PulseMeter.c,51 :: 		while(1)
L_main12:
;PulseMeter.c,53 :: 		x=0;
	CLRF       _x+0
;PulseMeter.c,55 :: 		while(IR_Tx){
L_main14:
	BTFSS      RA3_bit+0, BitPos(RA3_bit+0)
	GOTO       L_main15
;PulseMeter.c,56 :: 		while(pc<=0){}
L_main16:
	CLRF       R1+0
	BTFSC      RA4_bit+0, BitPos(RA4_bit+0)
	INCF       R1+0, 1
	MOVF       R1+0, 0
	SUBLW      0
	BTFSS      STATUS+0, 0
	GOTO       L_main17
	GOTO       L_main16
L_main17:
;PulseMeter.c,57 :: 		while(pc>0){}
L_main18:
	CLRF       R1+0
	BTFSC      RA4_bit+0, BitPos(RA4_bit+0)
	INCF       R1+0, 1
	MOVF       R1+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_main19
	GOTO       L_main18
L_main19:
;PulseMeter.c,58 :: 		x=x++;
	INCF       _x+0, 1
;PulseMeter.c,59 :: 		}
	GOTO       L_main14
L_main15:
;PulseMeter.c,60 :: 		pulsecount = x;
	MOVF       _x+0, 0
	MOVWF      _pulsecount+0
;PulseMeter.c,61 :: 		pulserate = x;//here some modification required bcz pulse rate =pulse count/time required
	MOVF       _x+0, 0
	MOVWF      _pulserate+0
;PulseMeter.c,62 :: 		display();
	CALL       _display+0
;PulseMeter.c,63 :: 		Delay_ms(5000);
	MOVLW      51
	MOVWF      R11+0
	MOVLW      187
	MOVWF      R12+0
	MOVLW      223
	MOVWF      R13+0
L_main20:
	DECFSZ     R13+0, 1
	GOTO       L_main20
	DECFSZ     R12+0, 1
	GOTO       L_main20
	DECFSZ     R11+0, 1
	GOTO       L_main20
	NOP
	NOP
;PulseMeter.c,64 :: 		}
	GOTO       L_main12
;PulseMeter.c,65 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
