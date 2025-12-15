#include <def21060.h>
#include <asm_sprt.h>
#include "constants.h"

.global _SetupSPORT;
.global _ReadIOPReg;
.global _SetupLPORT;
.global ProcessBuffer;

/*
int *histogram (int out[],
				const int in[],
				int out_len,
				int samples,
				int bin_size);
*/
.extern _histogram;



.section/dm seg_dmda;

.var InBuffer1[cnN];
.var InBuffer2[cnN];

.var OutBuffer1[cnB];
.var OutBuffer2[cnB];

//in_TCB
.var TCB_input1[8] = 0, 0, 0, InBuffer2-0x200000, 
						TCB_input2+7, 
						@InBuffer1, 
						1,
						InBuffer1;
.var TCB_input2[8] = 0, 0, 0, InBuffer1-0x200000,
						TCB_input1+7, 
						@InBuffer2, 
						1, 
						InBuffer2;


//out_TCB
.var TCB_output1[8] = 0, 0, 0, OutBuffer2-0x200000, 
						TCB_output2+7, 
						@OutBuffer1, 
						1, 
						OutBuffer1;
.var TCB_output2[8] = 0, 0, 0, OutBuffer1-0x200000, 
						TCB_output1+7, 
						@OutBuffer2, 
						1, 
						OutBuffer2;
	
.section/pm seg_pmco;



// init sport0
// IN:	int transmit (0 or 1),	R4
//		int SRCTL	 		 ,	R8
//		int div				 ,	R12
_SetupSPORT:
		
		// sport0
		R4 = PASS R4;
		If NE jump transmit_0;
receive_0:
		DM(RDIV0) = R12;
		R12 = TCB_input1+7;
		DM(CP0) = R12;
		DM(SRCTL0) = R8;
		jump finish;
transmit_0:
		DM(TDIV0) = R12;		
		R12 = TCB_output1+7;
		DM(CP2) = R12;
		DM(STCTL0) = R8;
		jump finish;
		
		
finish:		 
		leaf_exit;
_SetupSPORT.end:
		nop;
		
		
// set up link port
// IN:	int lar 		,	R4 
//		int lcom	 	,	R8 
//		int lctl		,	R12
_SetupLPORT:
		dm(LAR)=r4;
		dm(LCOM)=r8;
		dm(LCTL)=r12;
		leaf_exit;
_SetupLPORT.end:
		nop;		
		
		
				
// read with iop register, need for read GPx 
// IN:	int address,	R4
// OUT: int value,		R0			
_ReadIOPReg:
		// save I8 to prevent data loss
		puts = I8;
		
		I8 = R4;		
		R0 = pm(I8, M13);
		
		I8 = gets(1);					
		alter(1);		
		
		leaf_exit;
_ReadIOPReg.end:
		nop;
		
		
// prepare outData											
// in:	int* 	in_buffer,	R4 
//		int 	n,			R8
//		int* 	out_buffer,	R12 
//		int 	b,			stack
// 		float	inverseB	stack
ProcessBuffer:
		save_reg;
		M0 = 1;
		M8 = 1;
		
		I5 = R4;			// in buffer ptr
		R8 = R8;			// in buffer len (n)
		I8 = R12;			// out buffer ptr
		R5 = dm(1, i6);		// out buffer len (b)
		F6 = dm(2, i6);		// 1/b
		
		R10 = 0;			// max value
		LCNTR=R8, do xxx until LCE;
			R0 = DM(I5, M0);	
			comp(R10, R0);
			if gt jump skip;
			R10 = R0;
skip:		nop;
xxx:		nop;
		i5 = R4;			// restore in_buff ptr
		
		// divide
		F10 = float R10;
		F10 = F10 * F6;
		R10 = fix F10;
		
		// print to link port
		DM(LBUF2) = R10;
		R10 = R10+1;
		save_reg;
		puts = R10;			// bin_size
		puts = R8;			// samples
		
		
		R4 = I8;
		R8 = I5;
		R12 = R5;
		
		cjump _histogram (db);
			dm(I7, M7) = R2;
			dm(I7, M7) = PC;
		alter(2);
		restore_reg;
		
		restore_reg;		
		leaf_exit;
ProcessBuffer.end:					
		nop;				
		
	
				
							