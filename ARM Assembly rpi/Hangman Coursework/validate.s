                                    @ validates the character that the user inputted by returning a 0 if invalid, or 1 if valid
.global validate
validate:

    push {r1-r10, lr}
	cmp r0, #65					@ check input > 64
    blt invalid                 @ jump to invalid function

    cmp r0, #122                @ check input < 123
    bgt invalid                 @ jump to invalid function

    cmp r0, #90                 @ if input > 90
    ble step                    @ skip the next part if it's less uppercase
    cmp r0, #97                 @ but < 97
    blt invalid                 @ jump to invalid function

step:

    mov r0, #1                  @ otherwise, return 1 in r0
    pop {r1-r10, lr}
    bx lr

invalid:

    @ prints invalid message

    ldr r0, =invalidMsg         @ invalid message memory address
    bl printf                   @ call to printf
    mov r0, #0                  @ stdin
    bl fflush                   @ call to fflush function
    mov r0, #0                  @ return 0 in r0
    pop {r1-r10, lr}
    bx lr
