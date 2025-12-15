/*************************************************************/
/*                         Work with range                   */
/*************************************************************/
#include "def21060.h"
#define N 4000
#define GREEN 200

//------------------------------------------------------
// Source Vector 2 and Result Vector
.SECTION/DM dm_data;
.VAR input[N];
//------------------------------------------------------


//------------------------------------------------------
// Source Vector 2
.SECTION/PM pm_data;
.VAR output[N];
//------------------------------------------------------


//------------------------------------------------------
.SECTION/PM pm_irq_svc;
		nop;
		jump start;
		nop;
		nop;
//------------------------------------------------------


//------------------------------------------------------				
.SECTION/PM pm_code;
start:
		I0 = input;
		I1 = input;
		M0 = 1;
		M1 = 125;
		
		I8 = output;
		I9 = output;
		M8 = 1;
		M9 = 125;
		
		R2 = GREEN;
		R3 = 0x00FF00;
		R4 = 0xFF00FF;
		R5 = 0x00FF00;
		R6 = 0x0000FF;
		
		LCNTR = 110, DO xxx UNTIL LCE;
			I0 = I1;
			I8 = I9;
			LCNTR = 125, DO yyy UNTIL LCE;
				R1 = DM(I0, M0);
				
				R3 = R1 AND R3;
				R3 = LSHIFT R3 BY -8;
				R3 = R3 + R2;
				if not sz R3 = R6;
				R3 = LSHIFT R3 BY 8;
				R3 = R3 AND R5;
				
				R1 = R1 AND R4;
				R1 = R1 OR R3;
				
yyy:			PM(I8, M8) = R1;
			MODIFY(I1, M1);
xxx:		MODIFY(I9, M9);

wait:	IDLE;
		jump wait;
		
