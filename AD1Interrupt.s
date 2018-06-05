.global __AD1Interrupt
.equ	Nminus1,127
    
__AD1Interrupt:
    PUSH    DSRPAG
    PUSH    W4
    PUSH    W5
    PUSH    W8
    PUSH    W10

    MOV	    #0x0200,W4
    MOV	    W4,DSRPAG

    ;SYNC to High
    BSET    LATB,#6	; RB6 = 1

    
    BSET    MODCON,#0x0F    ; habilito Buffer Ciruclar
    BSET    MODCON,#0x0E    ; habilito Buffer Ciruclar
    
    ;inicializo los punteros
    MOV	    _posicion_inicial_del_vector_X,W10  ;W10 = dir de pos que corresponda
    MOV	    _posicion_inicial_del_vector_H,W8   ;W8  = &h[0]
    
    ;guardo la muestra actual x[n]
    MOV	    ADC1BUF0,W4
    MOV	    W4,[W10]
    
    CLR	    A, [W8]+=2, W4, [W10]+=2, W5

    REPEAT  #Nminus1
    MAC	    W4*W5, A, [W8]+=2, W4, [W10]+=2, W5

    ;SAC	    A,#0,W4	;W4 = Acc A
    ; W13 = Acc A, W10 -= 2words
    MOVSAC  B, [W8], W4, [W10]-=4, W5, W13
    SAC.R   A, #4, W13
    ;convierte Q15 to DAC format
    MOV	    #0x0800,W4
    XOR	    W4,W13,W13	;W13 = W4^W13

    ;SYNC to Low
    BCLR    LATB,#6	; RB6 = 0
    
    ;carga comando para el DAC (ademas del dato)
    MOV	    #0x0FFF,W4
    AND	    W4,W13,W13
    MOV	    #0x1000,W4
    IOR	    W4,W13,W13
    
    MOV	    W13,SPI1BUF	;DAC(externo) = W13
    
    ;W10 apunta donde debo guardar la proxima muestra de
    ;entrada.
    ;Pero, como W10 sera modificado por el micro al salir de
    ;esta interrupcion, lo debo salvar en alguna variable
    ;global
    MOV	    W10,_posicion_inicial_del_vector_X
    
    BCLR    MODCON,#15
    BCLR    MODCON,#14
    
    BCLR    IFS0,#13	;AD1IF = 0
    POP	    W10
    POP	    W8
    POP	    W5
    POP	    W4
    POP	    DSRPAG
    RETFIE
    .end
