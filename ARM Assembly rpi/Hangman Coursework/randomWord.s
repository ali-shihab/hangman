                                @ reads a random word from the 10 words in HangmanWords.txt and places it in buffer
.global randomWord
randomWord:

	@ generate a random number, mod by 10 

    push {r0-r10, lr}
	bl rand					@ generate random number
	bl mod10				@ jump to loop to find modulo 10
	mov r3, r0				@ move the new number to r4 - this is the loop limit
	ldr r0, =HangmanWords	@ r0 = HangmanWords file address
	ldr r1, =mode			@ r1 = file mode
	push {r3}
	bl fopen				@ open HangmanWords
	pop {r3}
	mov r5, r0				@ save file descriptor
	mov r4, #0				@ r4 = loop index 

readLoop:

	@ read the next word until the desired word is reached
	
    add r4, r4, #1			@ r4 = index+1
	ldr r0, =buffer			@ r0 = buffer memory address
	mov r1, #188			@ r1 = max chars read by fgets in a line
    mov r2, r5              @ r2 = file descriptor
	push {r3}
    bl fgets				@ call fgets function to read line
	pop {r3}
	cmp r4, r3				@ if index =/= loop limit,
	bne readLoop			@ loop again
    pop {r0-r10, lr}
    bx lr

mod10:

	push {lr}
	mov r7, #10				@ upper limit 10 is stored in r7
	udiv r5, r0, r7			@ divides an unsigned value
	mul r8, r5, r7			@ needed for computing the remainder
	sub r0, r0, r8			@ the mod (remainder)
	pop {lr}
	bx lr

