//------------------------------------
// ИТА ЮФУ (ИКТИБ)
// Программная инженерия
// Инженерия ПО для СРВ и ИВ
// Лабораторная работа №3. Вариант 0 
// ??????. ?????????????? ?????. ??????????? ?????????
// Создатель: Верещагин Данил Олегович
// КТбо2-9
// 03.04.2023
//------------------------------------
#include <def21060.h>
#define N 32
#define c_astr 2


//------------------------------------
// Память в DM
//------------------------------------
.SECTION/DM		dm_data;
.var input_buffer1[32];
.var input_buffer2[32];

.var in_select[2] = {input_buffer1, input_buffer2};

.var TCB_Block1[8] = 0, 0, 0, 0,
				TCB_Block2+7,
				@input_buffer1,
				1,
				input_buffer1;
				

.var TCB_Block2[8] = 0, 0, 0, 0,
				TCB_Block1+7,
				@input_buffer2,
				1,
				input_buffer2;
				
				
.var out_buf1[32];
.var out_buf2[32];

.var out_select[2] = {out_buf1, out_buf2};

.var TCB_BlockOut1[8] = 0, 0, 0, 0,
				TCB_BlockOut2+7,
				@out_buf1,
				1,
				out_buf1;
				

.var TCB_BlockOut2[8] = 0, 0, 0, 0,
				TCB_BlockOut1+7,
				@out_buf2,
				1,
				out_buf2;


//------------------------------------
// Память в PM
//------------------------------------
.SECTION/PM		pm_data;




//------------------------------------
// Прерыватель RESET
//------------------------------------
.SECTION/PM pm_irq_svc;
	nop;
	jump start;
	nop;
	nop;
	
	
//------------------------------------
// Прерыватель Timer High
//------------------------------------
.SECTION/PM pm_irq_spr0;
	M1 = R10;
	jump compute(db);
		I0 = dm(M1, I1); // Текущий входной буфер
		I7 = dm(M1, I5); // Текущий выходной буфер



//------------------------------------
// Программный код
//------------------------------------
.SECTION/PM pm_code;
start:
		
		// 2 входных буфера
		I1 = in_select;
		
		// 2 выходных буфера
		I5 = out_select;
		
		M0 = 1;

		// Начальные значения
		R12 = 0; //Y(0)
		R13 = c_astr; // C - ?????????
		R15 = -1; // ????????? ??? ????????? ?????
		R5 = 0; // delta
		R4 = 0; // Z
		R11 = 0;
		R9 = N;
		
		R10 = 0; // 0 - первый буфер, 1 - второй буфер
		R3 = 1;
		
		R0 = 2-1;
 		DM(RDIV0) = R0;	//div for X-samples
		
		// Настройка SPOT0 Receive
		R0 = 0x00C05F1;
		dm(SRCTL0) = R0; // Spen = 1
						 // Slen = 32(=32)
						 // ICLK = 1
						 // SDEN, SCHEN = 1
		
		// Настройка SPOT0 Transmit				 
		R0 = 0x00C05F1;
		dm(STCTL0) = R0; // Spen = 1
						 // Slen = 32(=32)
						 // ICLK = 1
						 // SDEN, SCHEN = 1
		
		// Настройка DMA-канала №0 на ввод через SPORT0
		R0 = TCB_Block1 + 7;
		dm(CP0) = R0;
		
		
		// Настройка DMA-канала №2 на вывод через SPORT0
		R0 = TCB_BlockOut1 + 7;
		dm(CP2) = R0;
		
						 
		// Настройка Link-порта
		R0 = 0x0003FEBF; // LAR: LBUF2<-> LPORT2
		dm(LAR) = R0;
		R0 = 0x00000000; // LCOM: 0
		dm(LCOM) = R0;
		R0 = 0x00000900; // LBUF2: L2en=1, L2tran=1 
		dm(LCTL) = R0;
		//R0 = 0x12345678;
		//dm(LBUF3) = R0;
		//R1 = dm(LBUF2);
		
		
		BIT SET IMASK SPR0I;
		BIT SET MODE1 IRPTEN;


wait: IDLE;
	  jump wait;
	  
	 
compute:

			lcntr = 32, do xxx until lce;
				R2 = dm(I0, M0); // Прочитать очередной отчёт 
				call compute_d(db);
					R4 = R12 - R2; // z(i) = Y(i) - y(i)
					nop;
			
				call update_pack(db);	
					R14 = R13*R0 (SSI); // delta
					R12 = R12 + R14; //Y(i)
		
		dm(LBUF2) = R12;
xxx: 	dm(I7, M0) = R12; // Записать очередной отсчёт Y
		R10 = R10 XOR R3;
		rti;



compute_d:

	
		R0 = 1;
		R1 = 1;
		R4 = PASS R4; // ???? ?? z(i)
		rts(db);
			if GE R0 = R0 * R15 (SSI); // sign(z) +1/-1
			if MS R1 = R1 - 1;	 


update_pack:
			R11 = lshift R11 by 1;
			R11 = R11 or R1;
		
		// ??????? ????????? ????? ? ????? ?????????
			R9 = R9 - 1;
			
			if NE jump next_bit;
			//dm(LBUF2) = R11;
			R9 = N;
			R11 = 0;
			nop;
		
next_bit:	rts;  
 		
	  	  