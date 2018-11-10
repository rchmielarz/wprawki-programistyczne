// Copyright © 1997-2018, Intel Corporation. All Rights Reserved.
//	
// This code is taken from Intel 64 and IA-32 Architectures Optimization Reference Manual April 2018 edition,
// chapter 12.16.3.6 Mixing MULX and AVX2 Instructions Example 12-41. Signed 64-bit Integer Conversion Utility.
//
// I have mearly cleaned the output of compilation from the icc compiler and changed labels.
	
	.section .data
quoTenThsn_mulplr_d:
	.word 6554
	.word 0
	.word 10486
	.word 0
	.word 8389
	.word 0
	.word 6711
	.word 0
	.word 6554
	.word 0
	.word 10486
	.word 0
	.word 8389
	.word 0
	.word 6711
	.word 0
mten_mulplr_d:
	.word -10
	.word 1
	.word -10
	.word 1
	.word -10
	.word 1
	.word -10
	.word 1
	.word -10
	.word 1
	.word -10
	.word 1
	.word -10
	.word 1
	.word -10
	.word 1
	
quotientsShift:
	.long 0x00000000,0x00000004,0x00000007,0x0000000a
	
asciiBias:
	.long 0x30303030,0x30303030,0x30303030,0x30303030
	
significantDigitsShift:
	.long 0x0004080c,0x80808080,0x80808080,0x80808080

	.section .text
	.global u32toascii

u32toascii:
	cmpl $10, %eax 
	jge .moreThanOneDigit 

	addl $'0', %eax 
	movl $1, %ebx 
	ret 

.moreThanOneDigit: 
	vmovd %eax, %xmm0 
	vpbroadcastd %xmm0, %xmm0 

	// calculate quotients of divisors 10, 100, 1000, 10000
	movl $quoTenThsn_mulplr_d, %ebx 
	vmovdqu (%rbx), %xmm1 
	vpmulhuw %xmm1, %xmm0, %xmm2

	// u16/10, u16/100, u16/1000, u16/10000
	vmovdqu quotientsShift(%rip), %xmm0 
	vpsrlvd %xmm0, %xmm2, %xmm2

	// 0, u16, 0, u16/10, 0, u16/100, 0, u16/1000
	vpslldq $6, %xmm2, %xmm3
	vpinsrw $1, %eax, %xmm3, %xmm3 
	vpor %xmm2, %xmm3, %xmm4 

	// produce 4 single digits in low byte of each dword
	movl $mten_mulplr_d, %ebx 
	vmovdqu (%rbx), %xmm0 
	vpmaddwd %xmm0, %xmm4, %xmm4

	// add bias for ascii encoding
	vmovdqu asciiBias(%rip), %xmm0 
	vpaddd %xmm4, %xmm0, %xmm2

	// pack 4 single digit into a dword, start with most significant digit
	vmovdqu significantDigitsShift(%rip), %xmm0 
	vpshufb %xmm0, %xmm2, %xmm3 
	
	cmpl $999, %eax 
	jle .lessThanFourDigits 

	movd %xmm3, %eax 
	movl $4, %ebx 
	ret 

.lessThanFourDigits: 
	cmpl $99, %eax 
	jle .twoDigits 

	movd %xmm3, %eax 
	sarl $8, %eax
	
	movl $3, %ebx 
	ret 

.twoDigits: 
	movd %xmm3, %eax
	sarl $16, %eax
	movl $2, %ebx 
	ret 

