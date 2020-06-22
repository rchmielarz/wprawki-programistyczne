  .section .data
  .set SYS_write, 64
  .set SYS_exit, 93

caption:
  .ascii "Liczba:"
caption_end:
  .set caption_len, caption_end - caption

  .macro write str, str_len
  addi a0, zero, 1
  la a1, \str
  addi a2, zero, \str_len
  addi a7, zero, SYS_write
  ecall
  .endm

  .section .bss
  .lcomm string, 32

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

_start:
  la a0, string
  li a1, 1234
  call u32toascii

  li t0, '\n'
  sb t0, (a0)
  addi a1, a1, 1

  # save string len
  mv t0, a1

  write caption, caption_len

  addi a0, zero, 1
  la a1, string
  mv a2, t0
  addi a7, zero, SYS_write
  ecall

  addi a0, x0, 0
  addi a7, x0, SYS_exit
  ecall

