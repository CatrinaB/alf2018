    
    ; script
start:
    ; asm
    readnumber r2 
        ; i: r3
        set r3 0
    store r3 r2
    ; run real_write
    ; push used regsters
        ; i: r2
        set r2 0
        load r2 r2
    push r2
    run real_write
    ; pop parameters
    set r2 8
    pushsp
    pop r3
    add r3 r3 r2
    push r3
    popsp
    mov r2 r1
    stop
    
    ; function real_write
real_write:
    ; Base pointer
    push r0
    pushsp
    pop r0
    ; Make space for variables
    set r4 8
    sub r3 r0 r4
    push r3
    popsp
    ; function
        ; attribution
            ; number: r3
            set r3 8
            add r3 r0 r3
            load r3 r3
            ; integer: r4
            set r4 0
        ; typecast int real
        set r6 1000
        div r5 r3 r6
        store r4 r5
        ; asm
            ; number: r3
            set r3 8
            add r3 r0 r3
            load r3 r3
        push r3 
        ; asm
        pop r3 
            ; fractional: r4
            set r4 -4
            add r4 r0 r4
        store r4 r3
        ; attribution
            ; expression mod
                ; fractional: r4
                set r4 -4
                add r4 r0 r4
                load r4 r4
                ; value int 1000
                set r5 1000
            mod r3 r4 r5
            ; fractional: r4
            set r4 -4
            add r4 r0 r4
        store r4 r3
        ; asm
            ; integer: r3
            set r3 0
            load r3 r3
        writenumber r3 
        ; asm
            ; value symbol .
            set r3 '.'
        write r3 
        ; asm
            ; fractional: r3
            set r3 -4
            add r3 r0 r3
            load r3 r3
        writenumber r3 
    ; Restore base pointer
    push r0
    popsp
    pop r0
    ; return
    ret