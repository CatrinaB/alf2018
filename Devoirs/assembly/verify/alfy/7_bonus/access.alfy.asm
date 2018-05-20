    
    ; script
start:
    ; attribution
        ; value int 6
        set r2 6
        ; element of array int: r3
            ; v: r4
            set r4 0
            ; value int 5
            set r5 5
        set r6 4
        mul r5 r5 r6
        add r3 r4 r5
    store r3 r2
    ; asm
        ; element of array int: r2
            ; v: r3
            set r3 0
            ; value int 5
            set r4 5
        set r5 4
        mul r4 r4 r5
        add r2 r3 r4
        load r2 r2
    writenumber r2 
    stop