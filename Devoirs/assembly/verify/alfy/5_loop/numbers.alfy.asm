    
    ; script
start:
    ; asm
    readnumber r2 
        ; x: r3
        set r3 0
    store r3 r2
    ; asm
    readnumber r2 
        ; y: r3
        set r3 4
    store r3 r2
    ; asm
    readnumber r2 
        ; w: r3
        set r3 8
    store r3 r2
    ; if
        ; expression <
            ; x: r3
            set r3 0
            load r3 r3
            ; y: r4
            set r4 4
            load r4 r4
        test r3 r4
        set r2 1
        jl next_0
        set r2 0
    next_0:
    set r3 1
    test r3 r2
    jne else_0
        ; for
        ; from
            ; x: r2
            set r2 0
            load r2 r2
        ; to
            ; y: r3
            set r3 4
            load r3 r3
        ; step
            ; w: r4
            set r4 8
            load r4 r4
        ; variable
        ; i: r5
        set r5 12
        mov r6 r2
        store r5 r6
    for_0:
        test r6 r3
        jg endfor_0
            ; asm
                ; i: r7
                set r7 12
                load r7 r7
            writenumber r7 
        add r6 r6 r4
        store r5 r6
        jmp for_0
    endfor_0:
    jmp endif_0
else_0:
        ; for
        ; from
            ; x: r2
            set r2 0
            load r2 r2
        ; to
            ; y: r3
            set r3 4
            load r3 r3
        ; step
            ; w: r4
            set r4 8
            load r4 r4
        ; variable
        ; i: r5
        set r5 12
        mov r6 r2
        store r5 r6
    for_1:
        test r6 r3
        jl endfor_1
            ; asm
                ; i: r7
                set r7 12
                load r7 r7
            writenumber r7 
        sub r6 r6 r4
        store r5 r6
        jmp for_1
    endfor_1:
endif_0:
    stop