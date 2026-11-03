_start:
    lui   x1, 0x80000
    addi  x5, x0, 0x11
    sw    x5, 0(x1)          # displays "11": el CPU arrancó y guarda bien
    lui   x12, 0x262
    addi  x12, x12, 0x5A0
    addi  x5, x0, 0x22
    sw    x5, 0(x1)          # displays "22": x12 (registro alto) OK
    lui   x13, 0x4787
    addi  x13, x13, -1856
    addi  x5, x0, 0x33
    sw    x5, 0(x1)          # displays "33": x13 + inmediato negativo OK
    addi  x14, x0, 10
    addi  x6, x0, 0
    addi  x7, x0, 0
    addi  x5, x0, 15
    sw    x5, 4(x1)          # LEDs encendidos
    addi  x5, x0, 0x44
    sw    x5, 0(x1)          # displays "44": sobrevivió a TODO
loop:
    j     loop