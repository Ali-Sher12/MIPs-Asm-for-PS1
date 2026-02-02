.psx
.create "ali_code.bin",0x80010000
.org 0x80011000   ;setting the address start for the data segment

mat1DIM: .dw 3,3        ; setting the dimentions of matrices and the matrices.
mat1: .dw 1,2,3,1,1,0,2,1,0

mat2DIM: .dw 3,2
mat2: .dw 1,2,1,0,2,1

mat3: .dw 0,0,0,0,0,0,0x99999999

.org 0x80010000 ;setting the address start for the code

Main:

    ;checking validity
    la $t0,mat1DIM    ; loading addresses of the dimentions
    la $t2,mat2DIM
    lw $t1,4($t0)     ; loading words from the address of the dimentions with an offset of 4 and 0
    lw $t3,0($t2)
    nop
    bne $t3,$t1,final_end     ; if they are not equal, jump to final_end, multiplication not possible
    nop

    ;t0,t1->dim of A
    ;t2,t3->dim of B
    ;t0,t3->dim of C

    lw $t0,0($t0)    ; A rows
    lw $t1,4($t2)    ; B cols
    lw $t2,0($t2)    ; B rows

    ;multiplication here

    la $t4,mat1
    la $t5,mat2
    la $t6,mat3

    li $a0,0
    Loop1:  ;a0 is index

    li $a1,0
    Loop2:  ;a1 is index

    li $a2,0
    li $t8,0
    Loop3:  ;a2 is index
    ; main multiplication logic

    ; accessing matrix 1 element via given formula
    move $a3,$a0
    mult $a3,$t2     ; result is stored in $hi $lo respectively, usually $hi is 0
    nop              ; comes after certain directives to consume a cycle, for safety
    mflo $a3         ; brings result from &lo into $a3
    add $a3,$a3,$a2

    li $s4,4
    mult $a3,$s4
    nop
    mflo $a3

    add $a3,$a3,$t4

    lw $s0,0($a3)

    ; accessing matrix 2 element via given formula
    move $a3,$a2
    mult $a3,$t1
    nop
    mflo $a3
    add $a3,$a3,$a1

    li $s4,4
    mult $a3,$s4
    nop
    mflo $a3

    add $a3,$a3,$t5

    lw $s1,0($a3)

    ; accessing matrix 3 element via given formula
    move $a3,$a0
    mult $a3,$t1
    nop
    mflo $a3
    add $a3,$a3,$a1

    li $s4,4
    mult $a3,$s4
    nop
    mflo $a3

    add $a3,$a3,$t6

    mult $s0,$s1
    nop
    mflo $t7    
    add $t8,$t8,$t7
    ; updating result in memory after each iteration
    sw $t8,0($a3)

    addi $a2,$a2,1
    blt $a2,$t0,Loop3
    nop    
    addi $a1,$a1,1    
    blt $a1,$t1,Loop2
    nop
    addi $a0,$a0,1
    blt $a0,$t3,Loop1
    nop

End_main:
j final_end
nop
; subroutines come here

final_end:
.close
