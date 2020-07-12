  .section .text
  .global numberToAscii
  # a0 - address of string
  # a1 - number to convert
  # returns:
  # a0 - current string position
  # a1 - characters written
numberToAscii:
  addi sp, sp, -32 # save registers
  sd s1, 24(sp)
  sd s2, 16(sp)
  sd s3, 8(sp)
  sd s4, (sp)
  li s1, 10
  li s2, 0

innerCalculationLoop:
  mv s3, a1
  divu a1, a1, s1
  remu s3, s3, s1

  addi s3, s3, '0'
  addi sp, sp, -1
  sb s3, (sp)
  addi s2, s2, 1

  bnez a1, innerCalculationLoop

  mv s4, s2
innerStoreLoop:
  lb s1, (sp)
  sb s1, (a0)
  addi sp, sp, 1
  addi a0, a0, 1
  addi s2, s2, -1

  bnez s2, innerStoreLoop

  mv a1, s4
  ld s1, 24(sp) # restore saved registers
  ld s2, 16(sp)
  ld s3, 8(sp)
  ld s4, (sp)
  addi sp, sp, 24
  ret

