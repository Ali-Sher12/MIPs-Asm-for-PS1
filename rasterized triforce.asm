.psx
.create "ali_code.bin",0x80010000
.org 0x80010000

IO_base_addr equ 0x1F80
GP0_ equ 0x1810
GP1_ equ 0x1814

Main:

lui $t0,IO_base_addr

;_________________

li $t1,0x00000000
sw $t1,GP1_($t0)

li $t1,0x01000000
sw $t1,GP1_($t0)

li $t1,0x03000000
sw $t1,GP1_($t0)

li $t1,0x08000001
sw $t1,GP1_($t0)

li $t1,0x06C60260
sw $t1,GP1_($t0)

li $t1,0x07042018
sw $t1,GP1_($t0)

;_________________

li $t1,0xE1000400
sw $t1,GP0_($t0)

li $t1,0xE3000000
sw $t1,GP0_($t0)

li $t1,0xE403BD3F
sw $t1,GP0_($t0)

li $t1,0xE5000000
sw $t1,GP0_($t0)

;_________________

li $t1,0x020000FF
sw $t1,GP0_($t0)

li $t1,0x00000000
sw $t1,GP0_($t0)

li $t1,0x00EF013F
sw $t1,GP0_($t0)

;_________________

li $t1, 0x2000FFFF
sw $t1, GP0_($t0)

li $t1, 0x00320032
sw $t1, GP0_($t0)

li $t1, 0x001E0064
sw $t1, GP0_($t0)

li $t1, 0x0064006E
sw $t1, GP0_($t0)

;_________________

loop_:
j loop_
nop

End_main:

.close
