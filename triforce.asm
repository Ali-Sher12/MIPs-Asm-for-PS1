.psx
.create "ali_code.bin",0x80010000
.org 0x80010000

IO_base_addr equ 0x1F80
GP0_ equ 0x1810
GP1_ equ 0x1814

; 0x1F801810 and 0x1F801814 are the addresses for the GPU ports

Main:

lui $t0,IO_base_addr
;_________________
; setting the display states and resolution

li $t1,0x00000000 ;reset GPU
sw $t1,GP1_($t0)

li $t1,0x01000000
sw $t1,GP1_($t0)

li $t1,0x03000000 ;enable display
sw $t1,GP1_($t0)

li $t1,0x08000001 ;seeting resolution, display mode 320 by 240
sw $t1,GP1_($t0)

li $t1,0x06C60260 ;horizontal range
sw $t1,GP1_($t0)

li $t1,0x07042018 ;vertical range
sw $t1,GP1_($t0)

;_________________
;setting up VRAM access

li $t1,0xE1000400 ; Draw mode settings
sw $t1,GP0_($t0)

li $t1,0xE3000000 ; top left corner
sw $t1,GP0_($t0)

li $t1,0xE403BD3F ; bottom right corner
sw $t1,GP0_($t0)

li $t1,0xE5000000 ; X and Y offset
sw $t1,GP0_($t0)

;_________________
; Drawing a grey square over the entire screen

li $t1,0x02646464 ; square code and color
sw $t1,GP0_($t0)

li $t1,0x00000000 ; top left vertex
sw $t1,GP0_($t0)

li $t1,0x00EF013F ; bottom right vertex
sw $t1,GP0_($t0)

;____ triangle 1

li $t1, 0x3000FF00 ; triangle directive and vertex 1 color
sw $t1, GP0_($t0)

li $t1, 0x002800A0 ; vertex 1 position
sw $t1, GP0_($t0)

li $t1, 0x0000FFFF ; vertex 2 color
sw $t1, GP0_($t0)

li $t1, 0x00640078 ; vertex 2 position
sw $t1, GP0_($t0)

li $t1, 0x000000FF ; vertex 3 color
sw $t1, GP0_($t0)

li $t1, 0x006400C8 ; vertex 3 position
sw $t1, GP0_($t0)

;____ triangle 2

li $t1, 0x3000FF00 ; triangle directive and vertex 1 color
sw $t1, GP0_($t0)

li $t1, 0x00640078 ; vertex 1 position
sw $t1, GP0_($t0)

li $t1, 0x0000FFFF ; vertex 2 color
sw $t1, GP0_($t0)

li $t1, 0x00A00050 ; vertex 2 position
sw $t1, GP0_($t0)

li $t1, 0x000000FF ; vertex 3 color
sw $t1, GP0_($t0)

li $t1, 0x00A000A0 ; vertex 3 position
sw $t1, GP0_($t0)

;____ triangle 3

li $t1, 0x3000FF00 ; triangle directive and vertex 1 color
sw $t1, GP0_($t0)

li $t1, 0x006400C8 ; vertex 1 position
sw $t1, GP0_($t0)

li $t1, 0x0000FFFF ; vertex 2 color
sw $t1, GP0_($t0)

li $t1, 0x00A000A0 ; vertex 2 position
sw $t1, GP0_($t0)

li $t1, 0x000000FF ; vertex 3 color
sw $t1, GP0_($t0)

li $t1, 0x00A000F0 ; vertex 3 position
sw $t1, GP0_($t0)

;_________________

loop_:
j loop_
nop

End_main:

.close
