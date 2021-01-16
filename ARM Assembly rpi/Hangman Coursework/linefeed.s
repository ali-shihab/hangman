                            @ function to separate outputs by ouputting linefeeds

.global linefeed
linefeed:

    push {r0-r10, lr}
    mov r0, #1              @ stdout
    ldr r1, =newline        @ output linefeed
    mov r2, #1              @ string length
    mov r7, #4              @ output system call
    svc 0
    pop {r0-r10, lr}
    bx lr
