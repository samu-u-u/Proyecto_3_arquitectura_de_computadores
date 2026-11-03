_start:
    lui   x1, 0x80000
    addi  x5, x0, 15
    sw    x5, 4(x1)          # LEDs encendidos YA: prueba que el CPU arrancó
    lui   x12, 0x262
    addi  x12, x12, 0x5A0    # leer/escribir registro alto x12
    lui   x13, 0x4787
    addi  x13, x13, -1856    # inmediato negativo
    addi  x14, x0, 10
    addi  x6, x0, 0
    addi  x7, x0, 0
    addi  x5, x0, 0x23
    sw    x5, 0(x1)          # "23": sobrevivió a todo
loop:
    j     loop