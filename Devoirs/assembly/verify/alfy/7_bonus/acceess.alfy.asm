    
    ; script
start:
    ; attribution
        ; value logic true
        set r2 1
        ; element of struct school: r3 element private
            ; s: r4
            set r4 0
        set r5 256
        add r3 r4 r5
    store r3 r2
    ; asm
        ; element of struct school: r2 element private
            ; s: r3
            set r3 0
        set r4 256
        add r2 r3 r4
        load r2 r2
    writenumber r2 
    stop