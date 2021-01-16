                            @ if input was lowercase, converts to uppercase
.global toUppercase
toUppercase:

    push {r2-r10, lr}
    ldr r0, =input
    ldrb r1, [r0]           @ load character guessed
    cmp r1, #90             @ if character is uppercase
    pople {r2-r10, lr}
    bxle lr                 @ return to calling function

    sub r1, r1, #32         @ otherwise, convert to uppercase
    strb r1, [r0]           @ update the input
    pop {r2-r10, lr}
    bx lr
