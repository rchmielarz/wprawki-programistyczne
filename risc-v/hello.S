  .section .data
  .set SYS_write, 64
  .set SYS_exit, 93

caption:
  .ascii "Liczba:"
caption_end:
  .set caption_len, caption_end - caption

  .macro write str, str_len
  addi a0, x0, 1
  la a1, \str
  addi a2, x0, \str_len
  addi a7, x0, SYS_write
  ecall
  .endm

  .section .bss
  .lcomm string, 32

  .section .text
  .global _start

_start:
  la t3, string

  li t4, '1'
  sb t4, (t3)

  li t4, '2'
  addi t3, t3, 1
  sb t4, (t3)

  li t4, '\n'
  addi t3, t3, 1
  sb t4, (t3)

  write caption, caption_len
  write string, 3

  addi a0, x0, 0
  addi a7, x0, SYS_exit
  ecall
