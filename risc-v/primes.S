  .section .data
  .set SYS_write, 64
  .set SYS_exit, 93

caption:
  .ascii "List of primes:\n"
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
  .lcomm primes, 4000 # 8 * 500
  .lcomm line, 100

  .section .text
  .global _start

  # a0 - address of string
  # a1 - number to convert
  # returns:
  # a0 - current string position
  # a1 - characters written
numberToAscii:
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

  # a0 - pointer to primes table
generatePrimes:
  li t0, 2
  sd t0, (a0)
  mv s1, a0 # s0 - beginning of primes table
  li t0, 3 # N(t0) - candidate for prime
  li t1, 500 # J(t1) - number of found primes

P2:
  addi a0, a0, 8
  addi t1, t1, -1
  sd t0, (a0)

  beqz t1, finish

P4:
  addi t0, t0, 2
  li t2, 8 # K(t2) - possible prime divisors

P6:
  add t3, s1, t2 # t3 - pointer to PRIME[K]
  ld t4, (t3) # t4 - PRIME[K]
  remu t5, t0, t4 # R(t5) - remainder
  div t6, t0, t4 # Q(t6) - quotient
  beqz t5, P4
  bge t4, t6, P2

  addi t2, t2, 8
  j P6

finish:
  ret

  # a0 - pointer to line
  # a1 - pointer to numbers table
  # returns:
  # a2 - number of characters writen to line
writeNumbersToString:
  addi sp, sp, -8
  sd ra, (sp)
  mv s2, a1
  li s3, 0 # M(s3) - number of lines to be written
  li s6, 400 # 50 * 8 - maximum number of lines to be written
writeLines:
  mv s4, s2
  add s4, s4, s3
  li s5, 10 # N(s5) - number of characters in a line

convertLine:
  ld a1, (s4)
  jal numberToAscii
  add a2, a2, a1
  add_char ' '
  addi s4, s4, 400 # 50 *8
  addi s5, s5, -1
  bnez s5, convertLine
  add_char '\n'

  addi s3, s3, 8
  bne s3, s6, writeLines

  ld ra, (sp)
  addi sp, sp, 8
  ret

_start:
  write caption, caption_len

  la a0, primes
  call generatePrimes

  la a0, line
  la a1, primes
  jal writeNumbersToString

  la a0, 1
  la a1, line
  addi a7, zero, SYS_write
  ecall

  addi a0, x0, 0
  addi a7, x0, SYS_exit
  ecall

