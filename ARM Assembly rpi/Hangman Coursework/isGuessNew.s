                        @ checks if the character inputted has already been guessed before, returns 0 if it has been guessed before and 1 if it hasn't
.global isGuessNew
isGuessNew:

    push {r1-r10, lr}
    ldr r0, =input			    
    ldrb r0, [r0]               @ load guessed character
    ldr r1, =guess

newGuessLoop:

    ldrb r2, [r1], #1           @ load character at Guess buffer, increment
    cmp r2, r0					@ if guessed character has been guessed before
    beq notNewGuess             @ jump to notNewGuess function
	cmp r2, #0					@ if r2 =/= 0
	bne newGuessLoop           	@ loop back through to the next character
    mov r0, #1                  @ return 1 in r0
    pop {r1-r10, lr}			
    bx lr                       @ return to calling function

notNewGuess:

    @ outputs message to say the character has already been entered and returns 0 in r0

    ldr r0, =newGuessMsg
    bl printf                   @ print message
    ldr r0, =guess
    bl printf                   @ print Guesses
    mov r0, #0                  @ stdin
    bl fflush                   @ call to fflush function
    bl linefeed                 @ insert new line
    mov r0, #0
    pop {r1-r10, lr}
    bx lr
    