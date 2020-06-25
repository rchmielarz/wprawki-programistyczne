  .section .data
  .set SYS_write, 64
  .set SYS_exit, 93

caption:
  .ascii "GCD("
caption_end:
  .set caption_len, caption_end - caption

  .macro write str, str_len
  addi a0, zero, 1
  la a1, \str
  addi a2, zero, \str_len
  addi a7, zero, SYS_write
  ecall
  .endm

  .macro add_char char
  li t0, \char
  sb t0, (a0)
  addi a2, a2, 1
  addi a0, a0, 1
  .endm

  .section .bss
  .lcomm string, 100

  .section .text
  .global _start

  # a0 - address of string
  # a1 - number to convert
  # returns:
  # a0 - current string position
  # a1 - characters written
u32toascii:
  li t3, 10
  li t4, 0

innerCalculationLoop:
  mv t5, a1
  divu a1, a1, t3
  remu t5, t5, t3

  addi t5, t5, '0'
  addi sp, sp, -1
  sb t5, (sp)
  addi t4, t4, 1

  bnez a1, innerCalculationLoop

  mv t1, t4
innerStoreLoop:
  lb t3, (sp)
  sb t3, (a0)
  addi sp, sp, 1
  addi a0, a0, 1
  addi t4, t4, -1

  bnez t4, innerStoreLoop

  mv a1, t1
  ret

  # a0 - first number
  # a1 - second number
  # returns:
  # a0 - greatest common divisor
gcd:
  rem t0, a0, a1
  beqz t0, answer
  mv a0, a1
  mv a1, t0
  j gcd
answer:
  mv a0, a1
  ret

_start:
  write caption, caption_len
  la a0, string
  li a1, 2166
  call u32toascii
  # copy size
  mv a2, a1

  add_char ','
  li a1, 6099
  call u32toascii
  add a2, a2, a1

  add_char ')'
  add_char '='

  #save current char address (a0) to a3
  mv a3, a0
  li a0, 2166
  li a1, 6099
  call gcd
  mv a1, a0
  mv a0, a3
  call u32toascii
  add a2, a2, a1

  add_char '\n'

  la a0, 1
  la a1, string
  addi a7, zero, SYS_write
  ecall

  addi a0, x0, 0
  addi a7, x0, SYS_exit
  ecall

