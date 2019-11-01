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
	
	.section .bss
	.lcomm line, 32

	.section .text
	.extern u32toascii
	.global _start

_start:
	write $preambule, $preambule_len

	// r8 - row counter
	movq $100, %r8
rowLoop:
	// r9 - column counter
	movq $200, %r9
columnLoop:
	movq $0, %rcx
	
	movq %r8, %rax
	call u32toascii
	movl %eax, line(%rcx)
	addq %rbx, %rcx
	movb $' ', line(%rcx)
	incq %rcx
	
	movq %r9, %rax
	call u32toascii
	movl %eax, line(%rcx)
	addq %rbx, %rcx
	movb $' ', line(%rcx)
	incq %rcx

	movq $51, %rax
	call u32toascii
	movl %eax, line(%rcx)
	addq %rbx, %rcx
	movb $'\n', line(%rcx)
	incq %rcx

	write $line, %rcx

	dec %r9
	cmp $0, %r9
	jnz columnLoop
rowLoopContinue:
	dec %r8
	cmp $0, %r8
	jnz rowLoop
	
_exit:
	movq $SYS_exit, %rax
	movq $SUCCESS, %rsi
	syscall	
