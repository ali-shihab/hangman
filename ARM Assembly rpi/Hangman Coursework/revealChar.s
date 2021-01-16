                        @ reveals the guessed character in each of the places that it appears in the word
.global revealChar
revealChar:

    pusheq {r2, lr}
	moveq r2, #0		@ initialise index to 0
	add r3, r3, #5
revealLoop:

	add r2, r2, #1		@ r2 = index of word
	cmp r3, r2			@ if r3 is not equal to r2, i.e. it is not the correct place in the word
	bne revealLoop  	@ loop back through to next character
	add r4, r4, #1		@ increase number of matches found by 1
	strb r0, [r5, r2]	@ replace the "_" in word with the guessed letter
	sub r3, r3, #5
	pop {r2, lr}
	bx lr
    