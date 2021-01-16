				@  Hangman game.	   			
	
.global main
main:
clearBuffers:

	@ function to 'clear cache' - overwrites each buffer with zeros

	ldr r0, =buffer
	mov r2, #0
	bl clear
	ldr r0, =guess
	bl clear
	ldr r0, =word
	bl clear
	ldr r0, =miss
	bl clear
	ldr r0, =s
	bl clear
	ldr r0, =chances
	mov r1, #6
	strb r1, [r0]


.data
	.include "clear.s"
	.align 2

.text
welcomePrompt:

	@ display welcome message, my URN, and option to exit or continue - generate a random word if chosen to continue 

	ldr r0, =welcome	@ load welcome message
	bl printf			@ call to printf
	ldr r0, =format		@ format is a character
    ldr r1, =input		@ input memory address
    bl scanf			@ call to scanf function
	ldr r0, =input
	ldrb r0, [r0]		@ inputted character
	cmp r0, #48			@ if input = 0,
	beq end				@ jump to end

.data
	welcome: .asciz "Author: Ali\nWelcome to Hangman!\nYou have 6 chances.\nIf you'd like to exit the game, you can enter 0 any time you're prompted. Otherwise, press any other key to continue.\n"
	.align 2
	input: .space 8
	.align 2
	format: .asciz " %c"
	.align 2

.text

	@ if user chose to continue

initialiseMiss:

    @ load 'Misses: ' into the Miss buffer

    ldr r0, =miss
    mov r1, #77         
    strb r1, [r0]       @ store M in 1st address
    mov r1, #105
    strb r1, [r0, #1]   @ store i in 2nd address
    mov r1, #115
    strb r1, [r0, #2]   @ store s in 3rd address
    strb r1, [r0, #3]   @ store s in 4th address
    strb r1, [r0, #5]   @ store s in 6th address
    mov r1, #101
    strb r1, [r0, #4]   @ store e in 5th address
    mov r1, #58
    strb r1, [r0, #6]   @ store : in 7th address
    mov r1, #32
    strb r1, [r0, #7]   @ store a space in 8th address

initialiseWord:

	@ load 'Word: ' into the Word buffer

    ldr r0, =word
    mov r1, #87         
    strb r1, [r0]       @ store W in 1st address
    mov r1, #111
    strb r1, [r0, #1]   @ store o in 2nd address
    mov r1, #114
    strb r1, [r0, #2]   @ store r in 3rd address
	mov r1, #100
    strb r1, [r0, #3]   @ store d in 4th address
	mov r1, #58
    strb r1, [r0, #4]   @ store : in 5th address
    mov r1, #32
    strb r1, [r0, #5]   @ store a space in 6th address

	bl randomWord		@ generate random word
	bl blankWord		@ generate blank word

.data
	.align 2
	miss: .space 120
	.align 2
	word: .space 216
	.align 2
	guess1: .asciz "Guessed: "
	.align 2
	guess: .space 200
	.align 2
	HangmanWords: .asciz "HangmanWords.txt"
	.align 2
	buffer: .space 188
	.align 2
	mode: .asciz "r"
	.align 2
	.include "randomWord.s"
	.align 2
	.include "blankWord.s"
	.align 2

.text
guessPrompt:

	@ print frame + word + misses

	bl prntframe			@ call to prntframe function

	@ prompt user for input and read it

	ldr r0, =prompt			@ r1 = prompt address
	bl printf				@ call to printf
	mov r0, #0				@ stdin
	bl fflush				@ call to fflush function
	ldr r0, =format			@ format is a character
    ldr r1, =input			@ input memory address
    bl scanf				@ call to scanf function

	ldr r0, =input			@ input memory address
	ldrb r0, [r0]			@ character guessed
	cmp r0, #48				@ if guessed character was a 0
	beq end					@ end game

validateGuess:

	@ validate the guess

	bl validate				@ call to input validation function
	cmp r0, #0				@ if validate returned a 0 in r0
	beq guessPrompt 		@ ask for another input
	bl toUppercase			@ call to function to convert lowercase characters to uppercase
	bl isGuessNew			@ call to newGuess function (checks if the guess hasn't been entered before)
	cmp r0, #0				@ if newGuess returned a 0 in r0
	beq guessPrompt			@ ask for another input
	bl updateGuesses		@ call to function to update the characters guessed so far
	
.data
	prompt: .asciz "Please enter a character [A-Z], or enter 0 to end the game."
	.align 2
	invalidMsg: .asciz "Invalid guess!"
	.align 2
	newGuessMsg: .asciz "Already guessed! You have already tried the following characters: "
	.align 2
	scaffold6: .asciz "scaffold6.txt"
	.align 2
	scaffold5: .asciz "scaffold5.txt"
	.align 2
	scaffold4: .asciz "scaffold4.txt"
	.align 2
	scaffold3: .asciz "scaffold3.txt"
	.align 2
	scaffold2: .asciz "scaffold2.txt"
	.align 2
	scaffold1: .asciz "scaffold1.txt"
	.align 2
	scaffold0: .asciz "scaffold0.txt"
	.align 2
	s: .space 800
	.align 2
	fmt: .asciz "%s"
	.align 2
	sLen = .-s
	.align 2
	newline: .asciz "\n"
	.align 2
	.include "linefeed.s"
	.align 2
	.include "prntframe.s"
	.align 2
	.include "validate.s"
	.align 2
	.include "toUppercase.s"
	.align 2
	.include "isGuessNew.s"
	.align 2
	.include "updateGuesses.s"
	.align 2

.text
checkIfCorrect:

		@ check if correct, reveals characters as they are checked

	bl checkCorrect			@ call to checkCorrect function
	cmp r0, #0				@ if r0 =/= 0
	bne correct				@ jump to correct function
	bl incorrect			@ call to incorrect function
	cmp r0, #0				@ if r0 returned 0, i.e. the player lost
	moveq r1, #0			@ signals the game was lost, not won
	beq playAgain			@ jump to playAgain function
	b guessPrompt			@ otherwise, ask for another input

correct:

	ldr r0, =correctMsg	@ r0 = correct memory address
	bl printf			@ call to printf function
	mov r0, #0			@ stdin
	bl fflush			@ call to fflush function

.data
	correctMsg: .asciz "Correct!"
	.align 2
	incorrectMsg: .asciz "Incorrect!"
	.align 2
	chances: .byte 6
	.align 2
	.include "checkCorrect.s"
	.align 2
	.include "revealChar.s"
	.align 2
	.include "incorrect.s"
	.align 2
	.include "missesf.s"
	.align 2

.text	
isWordComplete:

			@ checks if the word has been completed and terminates if it has

	ldr r0, =word		@ r0 = word memory address
	mov r1, #95			@ r1 = underscore memory address

isWordCompleteLoop:

	ldrb r2, [r0], #1		@ r1 = character at word memory address
	cmp r2, r1				@ if character hasn't been guess i.e. ="_"
	beq guessPrompt			@ ask for another input
	cmp r2, #0				@ otherwise, if the end of the word has been reached
	moveq r1, #1			@ signals the game was won, not lost
	beq playAgain			@ jump to terminate the program
	b isWordCompleteLoop	@ loop back through to next character

playAgain:

			@ function for the termination of the game. 

	@ display appropriate message and ask to play again

	bl prntframe			@ print frame for the last time
	ldr r0, =winMsg			@ r0 = winMsg memory address
	cmp r1, #0				@ if r1 = 0
	bne step3				@ step over the next few lines of code if r1 =/= 0, i.e. if the user won
	ldr r0, =loseMsg		@ r0 = loseMsg memory address
	bl printf				@ call to printf function
	ldr r0, =buffer			@ display the secret word
	bl printf				@ call to printf function
	mov r0, #0				@ stdin
	bl fflush				@ call to fflush function
	ldr r0, =playMsg		@ ask to play again

step3:

	bl printf				@ call to printf function
	mov r0, #0				@ stdin
	bl fflush				@ call to fflush function
	ldr r0, =format			@ format is a character
    ldr r1, =input			@ input memory address
    bl scanf				@ call to scanf function
	ldr r0, =input
	ldrb r0, [r0]			@ load input
	cmp r0, #48				@ if 0 was not entered
	bne main				@ start the game again

end:

	@ end the game 

	mov r7, #1		@ end game system call
	svc 0			@ make system call

.data
	winMsg: .asciz "Congratulations! You win!\nPlay again?\nPress 0 to exit the game, or any other character to play again."
	.align 2
	loseMsg: .asciz  "Sorry, you lose!\nThe secret word was: "
	.align 2
	playMsg: .asciz "Play again?\nPress 0 to exit the game, or any other character to play again."
	.align 2
	