                            @ resets the buffer inputted as a paramter in r0 with the element inputted as a parameter in r2
.global clear
clear:

    push {lr}       
   
clearLoop:

    @ loops through the buffer, resetting elements

    ldrb r1, [r0], #1       @ load the first element, increment
    cmp r1, r2              @ if the element is correct, jump to step4
    beq step4               @ loop to the next character
    strb r2, [r0, #-1]      @ otherwise, reset that element
    b clearLoop             @ loop to next element in buffer

step4:

    pop {lr}
    bx lr                   @ return to calling function
                    