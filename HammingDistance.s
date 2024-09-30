.data
    sequences: .space 32

    # Messages
    prompt:     .asciiz "Enter binary string "
    newline:    .asciiz "\n"
    result:     .asciiz "Hamming distance: "

.text
.globl main

main:
    # Initializing registers
    li $t0, 0
    la $t1, sequences

input_loop:
    # Print prompt
    li $v0, 4
    la $a0, prompt
    syscall

    # Read input
    move $a0, $t1
    li $a1, 9
    li $v0, 8
    syscall

    # next seq
    addi $t0, $t0, 1
    addi $t1, $t1, 8

    # Check if everything is read
    bne $t0, 4, input_loop


    li $t0, 0              # Outer loop counter
    la $t1, sequences

outer_loop:
    addi $t2, $t0, 1       # Inner loop counter
    move $t3, $t1
    addi $t3, $t3, 8

inner_loop:
    # Calculating Hamming distance
    li $t4, 0              # Hamming distance
    li $t5, 0              # Character counter

hamming_loop:
    lb $t6, 0($t1)
    lb $t7, 0($t3)
    beq $t6, $t7, skip_increment
    addi $t4, $t4, 1

skip_increment:
    addi $t1, $t1, 1
    addi $t3, $t3, 1
    addi $t5, $t5, 1
    bne $t5, 8, hamming_loop

    # Print result
    li $v0, 4
    la $a0, result
    syscall

    li $v0, 1
    move $a0, $t4
    syscall

    li $v0, 4
    la $a0, newline
    syscall


    subi $t1, $t1, 8


    addi $t2, $t2, 1
    bne $t2, 4, inner_loop


    addi $t0, $t0, 1
    addi $t1, $t1, 8
    bne $t0, 3, outer_loop

    # Exit 
    li $v0, 10
    syscall
