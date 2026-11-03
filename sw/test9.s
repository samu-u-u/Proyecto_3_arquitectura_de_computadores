_start:
    j     real
    addi  x0, x0, 0
    addi  x0, x0, 0
    addi  x0, x0, 0
    addi  x0, x0, 0
    addi  x0, x0, 0
    addi  x0, x0, 0
    addi  x0, x0, 0
    addi  x0, x0, 0
    addi  x0, x0, 0
    addi  x0, x0, 0
    addi  x0, x0, 0
    addi  x0, x0, 0
    addi  x0, x0, 0
    addi  x0, x0, 0
    addi  x0, x0, 0
    addi  x0, x0, 0
real:
    lui   x1, 0x80000
    lui   x12, 0x262
    addi  x12, x12, 0x5A0
    lui   x13, 0x4787
    addi  x13, x13, -1856
    addi  x14, x0, 10
    addi  x6, x0, 0
    addi  x7, x0, 0
    addi  x5, x0, 15
    sw    x5, 4(x1)
    addi  x5, x0, 0x23
    sw    x5, 0(x1)
loop:
    j     loop