                                @ checks if the guess is correct, calls the revealChar function (if it's correct) as it checks and returns 0 if incorrect, 1 if correct
.global checkCorrect
checkCorrect:

    push {r1-r10, lr}
	ldr r0, =input
	ldr r0, [r0]				@ load guessed character
	ldr r1, =buffer				@ r1 = buffer memory address
	mov r3, #0					@ r3 = index of the guessed char in the random word and is the limit of the revealChar loop
	mov r4, #0					@ r4 = counts number of matches found
	ldr r5, =word				@ r5 = word memory address

checkLoop:

	ldrb r2, [r1], #1			@ r2 = char at buffer memory address, then increment
	add r3, r3, #1				@ r3 = index +1
	cmp r0, r2					@ if r2 = r0
	bleq revealChar 			@ call to revealChar function
	cmp r2, #10					@ if the end of the random word is not reached
	bne checkLoop				@ loop back through to next character
	cmp r4, #0					@ if r4 = 0, i.e. number of matches = 0
	moveq r0, #0                @ return 0 in r0
	beq step2					@ if r4 = 0, step over line 23
	mov r0, #1					@ otherwise, return 1 in r0

step2:

    pop {r1-r10, lr}
    bx lr
    