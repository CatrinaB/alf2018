    
    ; script
start:
    ; asm
        ; run sum
        ; push used regsters
            ; value int 3
            set r2 3
        push r2
            ; value int 7
            set r2 7
        push r2
        run sum
        ; pop parameters
        set r2 16
        pushsp
        pop r3
        add r3 r3 r2
        push r3
        popsp
        mov r2 r1
    writenumber r2 
    stop
    
    ; function sum
sum:
    ; Base pointer
    push r0
    pushsp
    pop r0
    ; Make space for variables
    set r3 0
    sub r2 r0 r3
    push r2
    popsp
    ; function
            ; expression +
                ; n1: r3
                set r3 8
                add r3 r0 r3
                load r3 r3
                ; n2: r4
                set r4 12
                add r4 r0 r4
                load r4 r4
            add r2 r3 r4
        ; Restore base pointer
        push r0
        popsp
        pop r0
        ; return value
        mov r1 r2
        ret
    ; Restore base pointer
    push r0
    popsp
    pop r0
    ; return
    ret