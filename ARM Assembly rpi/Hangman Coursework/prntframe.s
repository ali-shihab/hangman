

.global prntframe

prntframe:

	@ function to print frame + the blank word + misses based on chances left	 

printScaffold:

	push {r1-r10, lr}
    bl linefeed                 @ insert new line
	bl linefeed					@ insert new line

	ldr r0, =chances
	ldr r0, [r0]				@ load number of chances left 

    cmp r0, #6                  @ if chances left = 6
    ldreq r0, =scaffold6		@ r0 = scaffold6 memory address

	cmp r0, #5					@ if chances left = 5
	ldreq r0, =scaffold5		@ r0 = scaffold5 memory address

	cmp r0, #4					@ if chances left = 4
	ldreq r0, =scaffold4		@ r0 = scaffold4 memory address

	cmp r0, #3 					@ if chances left = 3
	ldreq r0, =scaffold3		@ r0 = scaffold3 memory address

	cmp r0, #2					@ if chances left = 2
	ldreq r0, =scaffold2		@ r0 = scaffold2 memory address

	cmp r0, #1					@ if chances left = 1
	ldreq r0, =scaffold1		@ r0 = scaffold1 memory address

	cmp r0, #0					@ if chances left = 0
	ldreq r0, =scaffold0		@ r0 = scaffold0 memory address

	ldr r1, =mode		    	@ r1 = file mode
    bl fopen					@ call to fopen function
    mov r4, r0                  @ save file pointer
    mov r5, #0                  @ prntloop index

prntloop:

	@ print frame

    add r5, r5, #1              @ increment index
	ldr r0, =s				    @ scaffold buffer memory address
	ldr r1, =sLen				@ max length is length of buffer
    mov r2, r4                  @ r2 = file pointer
	bl fgets					@ call to fgets function
    ldr r0, =s                  @ scaffold buffer memory address
    bl printf                   @ call to printf function
    mov r0, #0                  @ stdin
    bl fflush                   @ call to fflush function
    cmp r5, #7                  @ if r4 =/=
    bne prntloop                @ loop back to next line
    
	bl linefeed
	bl linefeed

	@ print blank word

	ldr r0, =word				@ load blank word 
	bl printf					@ call to printf function
	mov r0, #0					@ stdin
	bl fflush					@ call to fflush function

	bl linefeed

	@ print guesses

	ldr r0, =guess1				@ load part 1 of the guessed messge
	bl printf
	mov r0, #0					@ stdin
	bl fflush					@ call to fflush function	
	ldr r0, =guess				@ load guessed
	bl printf					@ call to printf function
	mov r0, #0					@ stdin
	bl fflush					@ call to fflush function

	bl linefeed

	@ print misses

	ldr r0, =miss				@ load misses
	bl printf					@ call to printf function
	mov r0, #0					@ stdin
	bl fflush					@ call to fflush function

	bl linefeed
	bl linefeed					

	pop {r1-r10, lr}
	bx lr
