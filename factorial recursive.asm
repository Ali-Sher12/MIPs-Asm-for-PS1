.psx
.create "ali_code.bin",0x80010000
.org 0x80011000

result_: .dw 0,0x99999999

.org 0x80010000

Main:

    li $a0,6 ;the number of which the factorial needs to be calculated of
    li $t0,1 ;counter for comparing
    li $t2,1
    la $s0,result_
    jal factorial_
    nop

    sw $t2,0($s0) ;storing the final result

End_main:
j final_end
nop

; subroutines come here
factorial_:
    addi $sp,$sp,-4
    sw $ra,0($sp)

    bgt $t0,$a0,end_it
    nop
    ; logic

    mult $t0,$t2
    mflo $t2
    nop

    addi $t0,$t0,1

    jal factorial_
    nop

    end_it:

    lw $ra,0($sp)
    addi $sp,$sp,4
    jr $ra
    nop

final_end:
.close
