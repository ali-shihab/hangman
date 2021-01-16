                            @ represent the letters in the word as underscores ("_")
.global blankWord
blankWord:

    push {r3-r10, lr}
    ldr r0, =buffer         @ load buffer memory address
    ldr r1, =word           @ load word memory address
    mov r3, #95             @ r2 = underscore ascii code
    mov r4, #5              @ loop index

addBlanks:

    @ fill word with as many blanks as the amount of characters in buffer

    ldrb r2, [r0], #1
    cmp r2, #10
    popeq {r3-r10, lr}
    bxeq lr
    add r4, r4, #1
    strb r3, [r1, r4]
    b addBlanks



