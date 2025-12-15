#include <def21060.h>
#include <signal.h>
#include <stats.h>
#include "constants.h"
 
extern void SetupSPORT(int, int, int);
extern void SetupLPORT(int, int, int);
extern int ReadIOPReg(int);
extern "asm" ProcessBuffer(int *, int, int*, int, float);

 
void SPORT0_DMA_Receive_Handler(int sig)
{
 	int *ptrInBuffer;	
 	int *ptrOutBuffer;
 	
 	
 	ptrInBuffer = (int *)ReadIOPReg(GP0);
 	ptrInBuffer += 0x20000;
 	
 	
 	ptrOutBuffer = (int *)ReadIOPReg(GP2);
 	ptrOutBuffer += 0x20000;
 	
 	ProcessBuffer(ptrInBuffer, cnN, ptrOutBuffer, cnB, cnInverseB);
 	
 	return;
}

				
 

int main()
{
	interrupt(SIG_SPR0I, SPORT0_DMA_Receive_Handler);
	
	SetupLPORT(0x0003febf, 0x00004000, 0x00000900);
	SetupSPORT(0, 0xC05F1, cnDIVISOR);
	SetupSPORT(1, 0xC05F1, cnDIVISOR*cnN/cnB);
	
	return 0;
}
