                        @ prints message to say the guess was incorrect, updates the chances left, returns 0 in r0 if player lost, returns 1 in r0 if player has chances left
.global incorrect
incorrect:

    @ update list of misses + chances left

    push {r4-r10, lr}
    ldr r0, =input
    ldr r1, =miss           @ input + miss buffers are required parameters for missesf
	bl missesf              @ call to missesf function
    mov r4, #6              @ chances left = 6 - what is returned in r0
    sub r4, r4, r1          @ store chances left in r4
    ldr r1, =chances        
    strb r4, [r1]           @ update chances left

    @ print message to say guess was incorrect

	ldr r0, =incorrectMsg	@ r0 = incorrect message memory address
	bl printf				@ call to prinft function
    mov r0, #0              @ stdin
    bl fflush               @ call to fflush function

    @ return 1 if the player hasn't lost

    mov r2, r4              @ move chances left to r2
	cmp r2, #0				@ if chancesLeft =/= 0
    movne r0, #1            @ return 1 in r0
    popne {r4-r10, lr}
    bxne lr                 @ return to calling function

    @ return 0 if the player has lost
    
	bl prntframe            @ otherwise, call to prntframe function
    mov r0, #0              @ return 0 in r0
    pop {r4-r10, lr}
    bx lr                   @ return to calling function
    