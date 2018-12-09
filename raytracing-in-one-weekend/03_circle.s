	.section .data
	.set SYS_exit, 60
	.set SYS_write, 1
	.set SUCCESS, 0
	.set STDOUT, 1
preambule:
	.ascii, "P3\n200 100\n255\n"
preambule_end:	
	.set preambule_len, preambule_end - preambule

	.macro write str, str_len
	movq $SYS_write, %rax
	movq $STDOUT, %rdi
	movq \str, %rsi
	movq \str_len, %rdx
	syscall
	.endm

rgb_multiplier:
	.single 255.0
nx:
	.single 200.0
ny:
	.single 100.0
mul00:
	.single -2.0
mul01:
	.single 4.0
mul10:
	.single -1.0
mul11:
	.single 2.0
mul2:
	.single 1.0
mul3:
	.single 3.0
zero:
	.single 0.0
half:
	.single 0.5
one:
	.single 1.0
zeroseven:
	.single 0.7
	
	.section .bss
	.lcomm line, 32
	
	.section .text
	.extern u32toascii
	.global _start

_start:
	write $preambule, $preambule_len
	
	// j (r8) - row counter
	movq $100, %r8
rowLoop:
	// i (r9) - column counter
	movq $0, %r9
columnLoop:
	movq $0, %rcx

	// u(xmm0) = i(r9) / nx(200);
	cvtsi2ss %r9, %xmm0
	vdivss nx, %xmm0, %xmm0
	// v(xmm1) = j(r8) / ny(100);	
	cvtsi2ss %r8, %xmm1
	vdivss ny, %xmm1, %xmm1
color:
	// B[0](xmm2) = -2(mul00) + u(xmm0)*4(mul01)
	vmulss mul01, %xmm0, %xmm2
	vaddss mul00, %xmm2, %xmm2
	// B[1](xmm3) = -1(mul10) + v(xmm1)*2(mul11)
	vmulss mul11, %xmm1, %xmm3
	vaddss mul10, %xmm3, %xmm3
	// B[2](xmm4) = 1(mul2)
	movss mul2, %xmm4
	// dotB(xmm5) = B[0]*B[0] + B[1]*B[1] + B[2]*B[2]
	vmulss %xmm2, %xmm2, %xmm2
	// can't reuse B1 (xmm3) because it is used later, instead use xmm5
	vmulss %xmm3, %xmm3, %xmm5 
	vmulss %xmm4, %xmm4, %xmm4
	vaddss %xmm5, %xmm2, %xmm5
	vaddss %xmm5, %xmm4, %xmm5
hit_sphere:
	// discriminant(xmm0) = 4.0(mul01) - 3.0(mul3)*dotB(xmm5);
	vmulss mul3, %xmm5, %xmm0
	movss mul01, %xmm1
	vsubss %xmm0, %xmm1, %xmm0
	// if (discriminant > 0)
	vcomiss zero, %xmm0
	jc color_continued
	movss rgb_multiplier, %xmm0
	movss zero, %xmm1
	movss zero, %xmm2
	jmp save_colors
color_continued:	
	// len(xmm5) = sqrt(dotB(xmm5))
	sqrtss %xmm5, %xmm5
	// unit_direction = B[1]/len
	// reversed order of source opperands for div and sub!
	vdivss %xmm5, %xmm3, %xmm5
	// t(xmm5) = 0.5*unit_direction + 0.5
	vmulss half, %xmm5, %xmm5
	vaddss half, %xmm5, %xmm5
	// 1-t (xmm3) = 1.0 - t
	// reversed order of source opperands for div and sub!
	movss one, %xmm3
	vsubss %xmm5, %xmm3, %xmm3
	// ir(xmm0) = 255.99*(1.0-t + t*0.5)
	vmulss half, %xmm5, %xmm1
	vaddss %xmm3, %xmm1, %xmm0
	vmulss rgb_multiplier, %xmm0, %xmm0
	// ig(xmm1) = 255.99*(1.0-t + t*0.7)
	vmulss zeroseven, %xmm5, %xmm1
	vaddss %xmm3, %xmm1, %xmm1
	vmulss rgb_multiplier, %xmm1, %xmm1	
	// ib(xmm2) = 255.99*(1.0-t + t)
	vaddss %xmm3, %xmm5, %xmm2
	vmulss rgb_multiplier, %xmm2, %xmm2
	
save_colors:	
	// save ir, ig and ib to rax, rdx, r10 before calling u32toascii
	cvtss2si %xmm0, %rax
	cvtss2si %xmm1, %rdx
	cvtss2si %xmm2, %r10

print_rgb:	
	call u32toascii
	movl %eax, line(%rcx)
	addq %rbx, %rcx
	movb $' ', line(%rcx)
	incq %rcx
	
	movq %rdx, %rax
	call u32toascii
	movl %eax, line(%rcx)
	addq %rbx, %rcx
	movb $' ', line(%rcx)
	incq %rcx

	movq %r10, %rax
	call u32toascii
	movl %eax, line(%rcx)
	addq %rbx, %rcx
	movb $'\n', line(%rcx)
	incq %rcx

	write $line, %rcx

	inc %r9
	cmp $200, %r9
	jne columnLoop
rowLoopContinue:
	dec %r8
	cmp $0, %r8
	jnz rowLoop
	
_exit:
	movq $SYS_exit, %rax
	movq $SUCCESS, %rsi
	syscall	
