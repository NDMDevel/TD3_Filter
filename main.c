/**
  Generated Main Source File

  Company:
    Microchip Technology Inc.

  File Name:
    main.c

  Summary:
    This is the main file generated using PIC24 / dsPIC33 / PIC32MM MCUs

  Description:
    This header file provides implementations for driver APIs for all modules selected in the GUI.
    Generation Information :
        Product Revision  :  PIC24 / dsPIC33 / PIC32MM MCUs - pic24-dspic-pic32mm : 1.55
        Device            :  dsPIC33EP128GP502
    The generated drivers are tested against the following:
        Compiler          :  XC16 v1.34
        MPLAB             :  MPLAB X v4.15
*/

/*
    (c) 2016 Microchip Technology Inc. and its subsidiaries. You may use this
    software and any derivatives exclusively with Microchip products.

    THIS SOFTWARE IS SUPPLIED BY MICROCHIP "AS IS". NO WARRANTIES, WHETHER
    EXPRESS, IMPLIED OR STATUTORY, APPLY TO THIS SOFTWARE, INCLUDING ANY IMPLIED
    WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY, AND FITNESS FOR A
    PARTICULAR PURPOSE, OR ITS INTERACTION WITH MICROCHIP PRODUCTS, COMBINATION
    WITH ANY OTHER PRODUCTS, OR USE IN ANY APPLICATION.

    IN NO EVENT WILL MICROCHIP BE LIABLE FOR ANY INDIRECT, SPECIAL, PUNITIVE,
    INCIDENTAL OR CONSEQUENTIAL LOSS, DAMAGE, COST OR EXPENSE OF ANY KIND
    WHATSOEVER RELATED TO THE SOFTWARE, HOWEVER CAUSED, EVEN IF MICROCHIP HAS
    BEEN ADVISED OF THE POSSIBILITY OR THE DAMAGES ARE FORESEEABLE. TO THE
    FULLEST EXTENT ALLOWED BY LAW, MICROCHIP'S TOTAL LIABILITY ON ALL CLAIMS IN
    ANY WAY RELATED TO THIS SOFTWARE WILL NOT EXCEED THE AMOUNT OF FEES, IF ANY,
    THAT YOU HAVE PAID DIRECTLY TO MICROCHIP FOR THIS SOFTWARE.

    MICROCHIP PROVIDES THIS SOFTWARE CONDITIONALLY UPON YOUR ACCEPTANCE OF THESE
    TERMS.
*/

#include "mcc_generated_files/mcc.h"
//#include "TD3_InitData.h"

#define N 128

uint16_t *posicion_inicial_del_vector_H;
uint16_t *posicion_inicial_del_vector_X;

__attribute__((space(ymemory),aligned(256))) uint16_t x[N];
__attribute__((space(xmemory),aligned(256))) uint16_t h[N]; //TD3_LOAD_MACRO;

void FIR_InitConfig(void);
void TD3_FilterConfig(void);

int main(void)
{
    SYSTEM_Initialize();    //Inicializa el micro de acuerdo a la configuracion
                            //del MCC
    
    FIR_InitConfig();       //Inicializo h[n]
    TD3_FilterConfig();     //Configuro el filtro (modulo addressing, y punteros
                            //iniciales para W8 y W10)
    
    ADC1_ChannelSelectSet(ADC1_CHANNEL_AN0);    //Seleccion del canal AN0
    ADC1_SamplingStart();                       //Inicia el muestreo
    TMR3_Start();                               //Inicia el TMR3 que al desbordar
                                                //vuelve a disparar el ADC
    
    while(1)
    {
        //Hago nada, el procesamiento DSP esta en la interrupcin por ADC.
    }
    return 0;
}

void FIR_InitConfig(void)
{
    h[0] = 0x0001;
    h[1] = 0x0011;
    h[2] = 0x0010;
    h[3] = 0xfffb;
    h[4] = 0xffe7;
    h[5] = 0xffec;
    h[6] = 0xfffe;
    h[7] = 0x0001;
    h[8] = 0xfff9;
    h[9] = 0xfffa;
    h[10] = 0x0000;
    h[11] = 0xffff;
    h[12] = 0x0007;
    h[13] = 0x000e;
    h[14] = 0xffec;
    h[15] = 0xffc9;
    h[16] = 0xffee;
    h[17] = 0xffc5;
    h[18] = 0xfe77;
    h[19] = 0xfd6b;
    h[20] = 0xffc4;
    h[21] = 0x04c6;
    h[22] = 0x05c7;
    h[23] = 0xfeaf;
    h[24] = 0xf655;
    h[25] = 0xf6df;
    h[26] = 0xfe1a;
    h[27] = 0xff72;
    h[28] = 0xf88b;
    h[29] = 0xf85f;
    h[30] = 0x0928;
    h[31] = 0x1ccb;
    h[32] = 0x1ccb;
    h[33] = 0x0928;
    h[34] = 0xf85f;
    h[35] = 0xf88b;
    h[36] = 0xff72;
    h[37] = 0xfe1a;
    h[38] = 0xf6df;
    h[39] = 0xf655;
    h[40] = 0xfeaf;
    h[41] = 0x05c7;
    h[42] = 0x04c6;
    h[43] = 0xffc4;
    h[44] = 0xfd6b;
    h[45] = 0xfe77;
    h[46] = 0xffc5;
    h[47] = 0xffee;
    h[48] = 0xffc9;
    h[49] = 0xffec;
    h[50] = 0x000e;
    h[51] = 0x0007;
    h[52] = 0xffff;
    h[53] = 0x0000;
    h[54] = 0xfffa;
    h[55] = 0xfff9;
    h[56] = 0x0001;
    h[57] = 0xfffe;
    h[58] = 0xffec;
    h[59] = 0xffe7;
    h[60] = 0xfffb;
    h[61] = 0x0010;
    h[62] = 0x0011;
    h[63] = 0x0001;
}

void TD3_FilterConfig(void)
{
    posicion_inicial_del_vector_H = h;
    posicion_inicial_del_vector_X = x;

    YMODSRT = (uint16_t)x;
    YMODEND = (uint16_t)(&x[N]-1);
    MODCONbits.YWM = 10;    //W10 -> Y Space pointer
    asm("NOP");             //para que la config del buffer circular no falle
                            //la siguiente instruccion despues de setear YWM
                            //no debe ser una lectura usando punteros
    XMODSRT = (uint16_t)h;
    XMODEND = (uint16_t)(&h[N]-1);
    MODCONbits.XWM = 8;     //W8 -> X Space pointer
    asm("NOP");             //idem YWM
    
}
/**
 End of File
*/