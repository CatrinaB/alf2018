    
    ; script
start:
    ; attribution
        ; value int 0
        set r2 0
        ; digits: r3
        set r3 4
    store r3 r2
    ; asm
    readnumber r2 
        ; number: r3
        set r3 0
    store r3 r2
    ; if
        ; expression =
            ; number: r3
            set r3 0
            load r3 r3
            ; value int 0
            set r4 0
        test r3 r4
        set r2 1
        je next_0
        set r2 0
    next_0:
    set r3 1
    test r3 r2
    jne endif_0
        ; attribution
            ; value int 1
            set r2 1
            ; digits: r3
            set r3 4
        store r3 r2
endif_0:
    ; while
while_0:
        ; expression !=
            ; number: r3
            set r3 0
            load r3 r3
            ; value int 0
            set r4 0
        test r3 r4
        set r2 1
        jne next_1
        set r2 0
    next_1:
    set r3 1
    test r3 r2
    jne endwhile_0
        ; attribution
            ; expression /
                ; number: r3
                set r3 0
                load r3 r3
                ; value int 10
                set r4 10
            div r2 r3 r4
            ; number: r3
            set r3 0
        store r3 r2
        ; attribution
            ; expression +
                ; digits: r3
                set r3 4
                load r3 r3
                ; value int 1
                set r4 1
            add r2 r3 r4
            ; digits: r3
            set r3 4
        store r3 r2
    jmp while_0
endwhile_0:
    ; asm
        ; digits: r2
        set r2 4
        load r2 r2
    writenumber r2 
    stop