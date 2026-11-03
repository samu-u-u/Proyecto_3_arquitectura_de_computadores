_start:
    lui   x1, 0x80000
    addi  x5, x0, 15        # enciende los 4 LEDs
    sw    x5, 4(x1)
    addi  x5, x0, 0x23      # displays muestran "23"
    sw    x5, 0(x1)
loop:
    j     loop