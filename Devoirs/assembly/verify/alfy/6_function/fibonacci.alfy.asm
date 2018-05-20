    
    ; script
start:
    ; asm
    readnumber r2 
        ; item: r3
        set r3 0
    store r3 r2
    ; asm
        ; run fibonacci
        ; push used regsters
            ; item: r2
            set r2 0
            load r2 r2
        push r2
        run fibonacci
        ; pop parameters
        set r2 8
        pushsp
        pop r3
        add r3 r3 r2
        push r3
        popsp
        mov r2 r1
    writenumber r2 
    ; asm
    pushsp 
    ; asm
    pop r2 
        ; stack: r3
        set r3 4
    store r3 r2
    ; asm
        ; stack: r2
        set r2 4
        load r2 r2
    writenumber r2 
    stop
    
    ; function fibonacci
fibonacci:
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
        ; if
            ; expression OR
                ; expression =
                    ; item: r4
                    set r4 8
                    add r4 r0 r4
                    load r4 r4
                    ; value int 0
                    set r5 0
                test r4 r5
                set r3 1
                je next_0
                set r3 0
            next_0:
                ; expression =
                    ; item: r5
                    set r5 8
                    add r5 r0 r5
                    load r5 r5
                    ; value int 1
                    set r6 1
                test r5 r6
                set r4 1
                je next_1
                set r4 0
            next_1:
            or r2 r3 r4
        set r3 1
        test r3 r2
        jne else_0
                ; value int 1
                set r2 1
            ; Restore base pointer
            push r0
            popsp
            pop r0
            ; return value
            mov r1 r2
            ret
        jmp endif_0
    else_0:
                ; expression +
                    ; run fibonacci
                    ; push used regsters
                    push r2
                        ; expression -
                            ; item: r4
                            set r4 8
                            add r4 r0 r4
                            load r4 r4
                            ; value int 2
                            set r5 2
                        sub r3 r4 r5
                    push r3
                    run fibonacci
                    ; pop parameters
                    set r3 8
                    pushsp
                    pop r4
                    add r4 r4 r3
                    push r4
                    popsp
                    pop r2
                    mov r3 r1
                    ; run fibonacci
                    ; push used regsters
                    push r2
                    push r3
                        ; expression -
                            ; item: r5
                            set r5 8
                            add r5 r0 r5
                            load r5 r5
                            ; value int 1
                            set r6 1
                        sub r4 r5 r6
                    push r4
                    run fibonacci
                    ; pop parameters
                    set r4 8
                    pushsp
                    pop r5
                    add r5 r5 r4
                    push r5
                    popsp
                    pop r3
                    pop r2
                    mov r4 r1
                add r2 r3 r4
            ; Restore base pointer
            push r0
            popsp
            pop r0
            ; return value
            mov r1 r2
            ret
    endif_0:
    ; Restore base pointer
    push r0
    popsp
    pop r0
    ; return
    ret