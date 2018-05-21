    
    ; script
start:
    ; attribution
        ; value int 5
        set r2 5
        ; element of array int: r3
            ; p: r4
            set r4 36
            ; value int 5
            set r5 5
        set r6 4
        mul r5 r5 r6
        add r3 r4 r5
    store r3 r2
    ; attribution
        ; value int 7
        set r2 7
        ; element of array int: r3
            ; v: r4
            set r4 0
            ; element of array int: r5
                ; p: r6
                set r6 36
                ; value int 5
                set r7 5
            set r8 4
            mul r7 r7 r8
            add r5 r6 r7
            load r5 r5
        set r6 4
        mul r5 r5 r6
        add r3 r4 r5
    store r3 r2
    ; asm
        ; element of array int: r2
            ; v: r3
            set r3 0
            ; element of array int: r4
                ; p: r5
                set r5 36
                ; value int 5
                set r6 5
            set r7 4
            mul r6 r6 r7
            add r4 r5 r6
            load r4 r4
        set r5 4
        mul r4 r4 r5
        add r2 r3 r4
        load r2 r2
    writenumber r2 
    stop