    
    ; script
start:
    ; asm
    readnumber r2 
        ; number: r3
        set r3 0
    store r3 r2
    ; run base16
    ; push used regsters
        ; number: r2
        set r2 0
        load r2 r2
    push r2
    run base16
    ; pop parameters
    set r2 8
    pushsp
    pop r3
    add r3 r3 r2
    push r3
    popsp
    mov r2 r1
    stop
    
    ; function base16
base16:
    ; Base pointer
    push r0
    pushsp
    pop r0
    ; Make space for variables
    set r4 4
    sub r3 r0 r4
    push r3
    popsp
    ; function
        ; if
            ; expression >
                ; number: r4
                set r4 8
                add r4 r0 r4
                load r4 r4
                ; value int 0
                set r5 0
            test r4 r5
            set r3 1
            jg next_0
            set r3 0
        next_0:
        set r4 1
        test r4 r3
        jne endif_0
            ; run base16
            ; push used regsters
            push r2
                ; expression /
                    ; number: r4
                    set r4 8
                    add r4 r0 r4
                    load r4 r4
                    ; value int 16
                    set r5 16
                div r3 r4 r5
            push r3
            run base16
            ; pop parameters
            set r3 8
            pushsp
            pop r4
            add r4 r4 r3
            push r4
            popsp
            pop r2
            mov r3 r1
            ; attribution
                ; expression mod
                    ; number: r5
                    set r5 8
                    add r5 r0 r5
                    load r5 r5
                    ; value int 16
                    set r6 16
                mod r4 r5 r6
                ; a: r5
                set r5 0
            store r5 r4
            ; if
                ; expression >=
                    ; a: r5
                    set r5 0
                    load r5 r5
                    ; value int 10
                    set r6 10
                test r5 r6
                set r4 1
                jge next_1
                set r4 0
            next_1:
            set r5 1
            test r5 r4
            jne else_1
                ; asm
                    ; expression -
                        ; expression +
                            ; value symbol a
                            set r6 'a'
                            ; a: r7
                            set r7 0
                            load r7 r7
                            ; typecast int symbol
                        add r5 r6 r7
                        ; value int 10
                        set r6 10
                    sub r4 r5 r6
                write r4 
            jmp endif_1
        else_1:
                ; asm
                    ; expression +
                        ; value symbol 0
                        set r5 '0'
                        ; a: r6
                        set r6 0
                        load r6 r6
                        ; typecast int symbol
                    add r4 r5 r6
                write r4 
        endif_1:
    endif_0:
    ; Restore base pointer
    push r0
    popsp
    pop r0
    ; return
    ret