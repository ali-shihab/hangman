                            @ updates list of characters guessed so far
.global updateGuesses
updateGuesses:

    push {r0-r10, lr}
    ldr r0, =input
    ldrb r0, [r0]           @ load current guessed character
    ldr r1, =guess          
   
updateLoop:

    @ loops through the guessed buffer until a zero is found, stores the guessed character at that address

    ldrb r2, [r1], #1       @ load character in guess buffer, increment
    cmp r2, #0              @ if the slot is not free,
    bne updateLoop          @ loop to the next character
    strb r0, [r1, #-1]      @ otherwise, store the current guessed character in that slot
    pop {r0-r10, lr}
    bx lr                   @ return to calling function
                    