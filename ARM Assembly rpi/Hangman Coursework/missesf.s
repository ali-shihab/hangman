                                      @ stores incorrect guesses and returns number of elements guessed elements in array thus far

.global missesf
missesf:

    @ add the next missed character. if function worked successfully, return 1 in r0 and number of misses in r1.
    
    push {r2-r10, lr}

    ldrb r0, [r0]                @ load value of guess buffer
    mov r3, #7                   @ loop index

add_loop:

    add r3, r3, #1
    ldrb r2, [r1, r3]           @ load the value at the address of buffer into r2 and
    cmp r2, #0                  @ if r2 =/= 0
    bne add_loop                @ loop to next value in the Misses buffer
    strb r0, [r1, r3]           @ otherwise, store the guessed character in the available address of misses
    sub r1, r3, #7              @ r1 = the amount of missed characters thus far
    mov r0, #1                  @ r0 = success return value
    pop {r2-r10, lr}
    bx lr                       @ branch back to calling function







    

