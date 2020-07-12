  .section .data
  .set SYS_write, 64
  .set SYS_exit, 93

caption:
  .ascii "Data of Easter:\n"
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
  .lcomm line, 100

  .section .text
  .global _start

_start:
  write caption, caption_len

  li a0, 2021 #Y(a0) - year for which the date of easter is computed
  # E1
  li a1, 19
  remu a1, a0, a1
  addi a1, a1, 1 #G(a1) - golden number

  # E2
  li a2, 100
  divu a2, a0, a2
  addi a2, a2, 1 #C(a2) - century

  # E3
  li a3, 3
  mul a3, a3, a2
  li t0, 4
  divu a3, a3, t0
  addi a3, a3, -12 #X(a3) - number of years in which leap year was dropped
  li a4, 8
  mul a4, a2, a4
  addi a4, a4, 5
  li t0, 25
  divu a4, a4, t0
  addi a4, a4, -5 #Z(a4) - special correction

  # E4
  li a5, 5
  mul a5, a5, a0
  li t0, 4
  divu a5, a5, t0
  sub a5, a5, a3
  addi a5, a5, -10 #D(a5) - Sunday

  # E5
  li a6, 11
  mul a6, a6, a1
  addi a6, a6, 20
  add a6, a6, a4
  sub a6, a6, a3
  li t0, 30
  remu a6, a6, t0 #E(a6) - epact (when a full moon occurs)
  li t0, 24
  beq a6, t0, increaseE
  li t0, 25
  beq a6, t0, checkIfGgt11
  j continueE5

checkIfGgt11:
  li t0, 11
  blt t0, a6, increaseE
  j continueE5

increaseE:
  addi a6, a6, 1
continueE5:

  # E6
  li a7, 44
  sub a7, a7, a6 #N(a7) - day of Easter

  li t0, 21
  blt a7, t0, increaseN
  j continueE6

increaseN:
  addi a7, a7, 30
continueE6:
  # E7
  addi a7, a7, 7
  add a5, a5, a7
  li t0, 7
  remu a5, a5, t0
  sub a7, a7, a5

  # E8
  li t0, 31
  blt t0, a7, resultIsApril

  la a0, line
  mv a1, a7
  call numberToAscii
  mv a2, a1

  add_char ' '
  add_char 'm'
  add_char 'a'
  add_char 'r'
  add_char 'z'
  add_char 'e'
  add_char 'c'
  add_char ' '

  li a1, 2021
  call numberToAscii
  add a2, a2, a1
  j printLine

resultIsApril:
  addi a7, a7, -31

  la a0, line
  mv a1, a7
  call numberToAscii
  mv a2, a1

  add_char ' '
  add_char 'k'
  add_char 'w'
  add_char 'i'
  add_char 'e'
  add_char 'c'
  add_char 'i'
  add_char 'e'
  add_char 'n'
  add_char ' '

  li a1, 2021
  call numberToAscii
  add a2, a2, a1

printLine:
  la a0, 1
  la a1, line
  addi a7, zero, SYS_write
  ecall

  addi a0, x0, 0
  addi a7, x0, SYS_exit
  ecall

