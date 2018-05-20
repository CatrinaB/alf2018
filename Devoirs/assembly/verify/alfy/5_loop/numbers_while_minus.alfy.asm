    
    ; script
start:
    ; repeat
repeat_0:
        ; asm
        readnumber r2 
            ; i: r3
            set r3 0
        store r3 r2
        ; attribution
            ; i: r2
            set r2 0
            load r2 r2
            ; h: r3
            set r3 4
        ; typecast real int
        set r5 1000
        mul r4 r2 r5
        store r3 r4
        ; asm
            ; h: r2
            set r2 4
            load r2 r2
        writenumber r2 
        ; expression >=
            ; i: r3
            set r3 0
            load r3 r3
            ; value int 0
            set r4 0
        test r3 r4
        set r2 1
        jge next_0
        set r2 0
    next_0:
    set r3 1
    test r3 r2
    je repeat_0
    stop