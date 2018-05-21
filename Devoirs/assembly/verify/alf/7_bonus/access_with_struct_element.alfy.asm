    
    ; script
start:
    ; asm
    readnumber r2 
        ; element of struct structure: r3 element position
            ; s: r4
            set r4 36
        set r5 0
        add r3 r4 r5
    store r3 r2
    ; asm
    readnumber r2 
        ; element of array int: r3
            ; v: r4
            set r4 0
            ; element of struct structure: r5 element position
                ; s: r6
                set r6 36
            set r7 0
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
            ; element of struct structure: r4 element position
                ; s: r5
                set r5 36
            set r6 0
            add r4 r5 r6
            load r4 r4
        set r5 4
        mul r4 r4 r5
        add r2 r3 r4
        load r2 r2
    writenumber r2 
    stop