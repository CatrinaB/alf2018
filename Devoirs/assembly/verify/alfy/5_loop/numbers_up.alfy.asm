    
    ; script
start:
    ; for
    ; from
        ; value int 1
        set r2 1
    ; to
        ; value int 6
        set r3 6
    ; step
        ; value int 1
        set r4 1
    ; variable
    ; i: r5
    set r5 0
    mov r6 r2
    store r5 r6
for_0:
    test r6 r3
    jg endfor_0
        ; asm
            ; i: r7
            set r7 0
            load r7 r7
        writenumber r7 
    add r6 r6 r4
    store r5 r6
    jmp for_0
endfor_0:
    stop